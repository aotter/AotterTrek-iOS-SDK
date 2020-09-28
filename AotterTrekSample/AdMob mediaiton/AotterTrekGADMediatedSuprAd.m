//
//  AotterTrekGADMediatedSuprAd.m
//  AotterTrekSample
//
//  Created by Aotter superwave on 2020/8/18.
//  Copyright © 2020 Aotter. All rights reserved.
//

#import "AotterTrekGADMediatedSuprAd.h"

@interface AotterTrekGADMediatedSuprAd ()<TKAdSuprAdDelegate>
@property TKAdSuprAd *suprAd;
@property(nonatomic, copy) NSMutableDictionary *extras;
@property(nonatomic, strong) GADNativeAdImage *mappedIcon;
@property(nonatomic, strong) UIView *mediaView;

@end

@implementation AotterTrekGADMediatedSuprAd
- (instancetype _Nullable )initWithTKSuprAd:(nonnull TKAdSuprAd *)suprAd{
    if(!suprAd.adData){
        return nil;
    }
    
    self = [super init];
    if (self) {
        _suprAd = suprAd;
        _suprAd.delegate = self;
        _extras = [[NSMutableDictionary alloc] init];
        [_extras setObject:suprAd forKey:@"trekAd"];
        
        NSString *imageUrl = _suprAd.adData[kTKAdImage_iconKey];
        NSURL *imageURL = [[NSURL alloc] initWithString:imageUrl];
        _mappedIcon = [[GADNativeAdImage alloc] initWithURL:imageURL scale:1];
        
    
        _mediaView = [[UIView alloc] init];
        [_suprAd registerTKMediaView:_mediaView];
        
    }
    return self;
}


- (BOOL)hasVideoContent {
    return YES;
}

- (UIView *)mediaView {
    return _mediaView;
}

- (NSString *)advertiser {
    return _suprAd.adData[kTKAdSponser];
}

- (NSString *)headline {
  return _suprAd.adData[kTKAdTitleKey];
}

- (NSArray *)images {
  return nil;
}

- (NSString *)body {
  return _suprAd.adData[kTKAdTextKey];
}

- (GADNativeAdImage *)icon {
  return self.mappedIcon;
}

- (NSString *)callToAction {
  return _suprAd.adData[kTKAdCall_to_actionKey];
}

- (NSDecimalNumber *)starRating {
  return nil;
}

- (NSString *)store {
  return nil;
}

- (NSString *)price {
  return nil;
}

- (NSDictionary *)extraAssets {
  return self.extras;
}

- (UIView *)adChoicesView {
  return nil;
}

-(void)didRenderInView:(UIView *)view clickableAssetViews:(NSDictionary<GADUnifiedNativeAssetIdentifier,UIView *> *)clickableAssetViews nonclickableAssetViews:(NSDictionary<GADUnifiedNativeAssetIdentifier,UIView *> *)nonclickableAssetViews viewController:(UIViewController *)viewController{
    [_suprAd registerAdView:view];
    [_suprAd registerPresentingViewController:viewController];
}

-(void)TKMyAppAdSuprAdOnClicked:(TKMyAppAdSuprAd *)ad{
    [GADMediatedUnifiedNativeAdNotificationSource mediatedNativeAdDidRecordClick:self];
}

@end
