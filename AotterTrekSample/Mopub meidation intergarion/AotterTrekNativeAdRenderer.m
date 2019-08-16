//
//  AotterTrekNativeAdRenderer.m
//  Aotter_pnn6ios
//
//  Created by Aotter superwave on 2019/8/15.
//  Copyright © 2019 Aotter. All rights reserved.
//

#import "AotterTrekNativeAdRenderer.h"
#import "MPStaticNativeAdRendererSettings.h"
#import "MPNativeAdRendererImageHandler.h"
#import "MPNativeAdRendering.h"
#import "AotterTrekNativeAdAdapter.h"
#import "MPNativeAdRenderingImageLoader.h"
#import "MPNativeAdConstants.h"


@interface AotterTrekNativeAdRenderer()<MPNativeAdRendererImageHandlerDelegate>
@property (nonatomic, strong) UIView<MPNativeAdRendering> *adView;
@property (nonatomic, strong) AotterTrekNativeAdAdapter *adapter;
@property (nonatomic, strong) Class renderingViewClass;
@property (nonatomic, strong) MPNativeAdRendererImageHandler *rendererImageHandler;
@property (nonatomic, assign) BOOL adViewInViewHierarchy;
@end

@implementation AotterTrekNativeAdRenderer
- (instancetype)initWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings{
    if (self = [super init]) {
        MPStaticNativeAdRendererSettings *settings = (MPStaticNativeAdRendererSettings *)rendererSettings;
        _renderingViewClass = settings.renderingViewClass;
        _viewSizeHandler = [settings.viewSizeHandler copy];
        _rendererImageHandler = [MPNativeAdRendererImageHandler new];
        _rendererImageHandler.delegate = self;
    }
    
    return self;
}

+ (MPNativeAdRendererConfiguration *)rendererConfigurationWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings{
    MPNativeAdRendererConfiguration *config = [[MPNativeAdRendererConfiguration alloc] init];
    config.rendererClass = [self class];
    config.rendererSettings = rendererSettings;
    config.supportedCustomEvents = @[@"AotterTrekNativeCustomEvent"];
    
    return config;
}

- (UIView *)retrieveViewWithAdapter:(id<MPNativeAdAdapter>)adapter error:(NSError *__autoreleasing *)error {
    if(!adapter || ![adapter isKindOfClass:[AotterTrekNativeAdAdapter class]]){
        
        return nil;
    }
    
    self.adapter = (AotterTrekNativeAdAdapter *)adapter;
    
    if(!self.renderingViewClass){
        return nil;
    }
    
    if([self.renderingViewClass respondsToSelector:@selector(nibForAd)]){
        self.adView = (UIView<MPNativeAdRendering> *) [[[self.renderingViewClass nibForAd] instantiateWithOwner:nil options:nil] firstObject];
    }
    else{
        self.adView = [[self.renderingViewClass alloc] init];
    }
    
    self.adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if([self.adView respondsToSelector:@selector(nativeTitleTextLabel)]){
        self.adView.nativeTitleTextLabel.text = [adapter.properties objectForKey:@"title"];
    }
    
    if([self.adView respondsToSelector:@selector(nativeMainTextLabel)]){
        self.adView.nativeMainTextLabel.text = [adapter.properties objectForKey:@"text"];
    }
    
    if([self shouldLoadMediaView]){
        UIView *mediaView = [self.adapter mainMediaView];
        UIView *mainImageView = [self.adView nativeMainImageView];
        
        mediaView.frame = mainImageView.bounds;
        mediaView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        mainImageView.userInteractionEnabled = YES;
        
        [mainImageView addSubview:mediaView];
    }
    
    return self.adView;
    
    
}


- (BOOL)shouldLoadMediaView{
    return [self.adapter respondsToSelector:@selector(mainMediaView)]
    && [self.adapter mainMediaView]
    && [self.adView respondsToSelector:@selector(nativeMainImageView)];
}


- (BOOL)hasIconView{
    if([self.adapter respondsToSelector:@selector(iconMediaView)]){
        if([self.adapter iconMediaView]){
            if([self.adView respondsToSelector:@selector(nativeIconImageView)]){
                return YES;
            }
        }
    }
    
    return NO;
    
//    return [self.adapter respondsToSelector:@selector(iconMediaView)]
//    && [self.adapter iconMediaView]
//    && [self.adView respondsToSelector:@selector(nativeIconImageView)];
}


-(void)adViewWillMoveToSuperview:(UIView *)superview{
    self.adViewInViewHierarchy = (superview != nil);
    
    if(superview){
        // Only handle the loading of the icon image if the adapter doesn't already have a view for it.
        if (![self hasIconView] && [self.adapter.properties objectForKey:kAdIconImageKey] && [self.adView respondsToSelector:@selector(nativeIconImageView)]) {
            [self.rendererImageHandler loadImageForURL:[NSURL URLWithString:[self.adapter.properties objectForKey:kAdIconImageKey]] intoImageView:self.adView.nativeIconImageView];
        }
        
        // Only handle the loading of the main image if the adapter doesn't already have a view for it.
        if (!([self.adapter respondsToSelector:@selector(mainMediaView)] && [self.adapter mainMediaView])) {
            if ([self.adapter.properties objectForKey:kAdMainImageKey] && [self.adView respondsToSelector:@selector(nativeMainImageView)]) {
                [self.rendererImageHandler loadImageForURL:[NSURL URLWithString:[self.adapter.properties objectForKey:kAdMainImageKey]] intoImageView:self.adView.nativeMainImageView];
            }
        }
        
        
        // Layout custom assets here as the custom assets may contain images that need to be loaded.
        if ([self.adView respondsToSelector:@selector(layoutCustomAssetsWithProperties:imageLoader:)]) {
            // Create a simplified image loader for the ad view to use.
            MPNativeAdRenderingImageLoader *imageLoader = [[MPNativeAdRenderingImageLoader alloc] initWithImageHandler:self.rendererImageHandler];
            [self.adView layoutCustomAssetsWithProperties:self.adapter.properties imageLoader:imageLoader];
        }
    }
}


#pragma mark - MPNativeAdRendererImageHandlerDelegate

- (BOOL)nativeAdViewInViewHierarchy{
    return self.adViewInViewHierarchy;
}
@end
