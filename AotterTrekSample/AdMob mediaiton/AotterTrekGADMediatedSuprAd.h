//
//  AotterTrekGADMediatedSuprAd.h
//  AotterTrekSample
//
//  Created by Aotter superwave on 2020/8/18.
//  Copyright © 2020 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>


@interface AotterTrekGADMediatedSuprAd : NSObject<GADMediatedUnifiedNativeAd>
- (instancetype _Nullable )initWithTKSuprAd:(nonnull TKAdSuprAd *)suprAd;

@end


