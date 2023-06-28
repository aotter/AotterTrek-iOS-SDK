//
//  AdmobNativeAdDemoCell.h
//  AotterTrekSample
//
//  Created by Robert on 2023/6/20.
//  Copyright © 2023 Aotter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>


NS_ASSUME_NONNULL_BEGIN

@interface AdmobNativeAdDemoCell : UITableViewCell

@property (nonatomic, strong) GADNativeAdView *nativeAdView;
@property (nonatomic, strong) GADMediaView *gadMediaView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *headlineView;
@property (nonatomic, strong) UILabel *bodyView;
@property (nonatomic, strong) UILabel *advertiserView;

- (void)setGADNativeAdData:(GADNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END
