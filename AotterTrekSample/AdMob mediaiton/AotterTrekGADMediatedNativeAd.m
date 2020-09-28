//
//  AotterTrekGADMediatedNativeAd.m
//  AotterTrekSample
//
//  Created by Aotter superwave on 2020/8/18.
//  Copyright © 2020 Aotter. All rights reserved.
//

#import "AotterTrekGADMediatedNativeAd.h"

@interface AotterTrekGADMediatedNativeAd()<TKAdNativeDelegate>
@property TKAdNative *nativeAd;
@property(nonatomic, copy) NSMutableDictionary *extras;
@property(nonatomic, strong) GADNativeAdImage *mappedIcon;


@end

@implementation AotterTrekGADMediatedNativeAd

- (instancetype)initWithTKNativeAd:(nonnull TKAdNative *)nativeAd{
    if(!nativeAd.AdData){
        return nil;
    }
    
    self = [super init];
    if (self) {
        _nativeAd = nativeAd;
        _nativeAd.delegate = self;
        _extras = [[NSMutableDictionary alloc] init];
        
        NSString *imageUrl = _nativeAd.AdData[kTKAdImage_iconKey];
        NSURL *imageURL = [[NSURL alloc] initWithString:imageUrl];
        _mappedIcon = [[GADNativeAdImage alloc] initWithURL:imageURL scale:1.0];
    }
    return self;
}


- (BOOL)hasVideoContent {
    return NO;
}

- (UIView *)mediaView {
    return nil;
}

- (NSString *)advertiser {
    return _nativeAd.AdData[kTKAdSponser];
}

- (NSString *)headline {
  return _nativeAd.AdData[kTKAdTitleKey];
}

- (NSArray *)images {
  return nil;
}

- (NSString *)body {
  return _nativeAd.AdData[kTKAdTextKey];
}

- (GADNativeAdImage *)icon {
  return _mappedIcon;
}

- (NSString *)callToAction {
  return _nativeAd.AdData[kTKAdCall_to_actionKey];
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
    [_nativeAd registerAdView:view];
    [_nativeAd registerPresentingViewController:viewController];
}

-(void)TKAdNativeWillLogClicked:(TKAdNative *)ad{
    [GADMediatedUnifiedNativeAdNotificationSource mediatedNativeAdDidRecordClick:self];
}

-(void)TKAdNativeWillLogImpression:(TKAdNative *)ad{
    [GADMediatedUnifiedNativeAdNotificationSource mediatedNativeAdDidRecordImpression:self];
}
@end


