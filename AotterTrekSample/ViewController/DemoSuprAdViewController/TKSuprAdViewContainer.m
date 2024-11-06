//
//  TKSuprAdViewContainer.m
//  AotterTrekSample
//
//  Created by Robert on 2024/11/6.
//  Copyright © 2024 Aotter. All rights reserved.
//

#import "TKSuprAdViewContainer.h"

static NSString *const kSuprAdEndPlaceID = @"548bcf22-2618-4ddf-9e36-10593a8b524b";
static const float kSuprAdEndHeightFactor = 9.0 / 16.0;

@interface TKSuprAdViewContainer () <TKAdSuprAdDelegate>
@property (nonatomic, strong) UIViewController *noUseVC;
@end

@implementation TKSuprAdViewContainer


#pragma mark - Initialzation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSuprAdView];
    }
    return self;
}

- (void)setupSuprAdView
{
    self.isCompleted = false;
    self.isError = false;
    
    //create UI
    self.noUseVC = [[UIViewController alloc] init];
    
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat heightFactor = 0.0;// or get factor from server

    if (heightFactor == 0.0) {
        heightFactor = kSuprAdEndHeightFactor;
    }
    CGFloat videoHeight = screenWidth * heightFactor;
    self.frame = CGRectMake(0, 0, screenWidth, videoHeight);
    self.backgroundColor = UIColor.clearColor;
    
    //load ad data
    self.videoSuprAd = [[TKAdSuprAd alloc] initWithPlace:kSuprAdEndPlaceID];
    self.videoSuprAd.delegate = self;
    [self.videoSuprAd fetchAd];
}


#pragma mark - TKAdSuprAdDelegate

- (void)TKAdSuprAdCompleted:(TKAdSuprAd *)suprAd
{
    self.isCompleted = true;
}

- (void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferedMediaViewSize:(CGSize)size
{
    [self.videoSuprAd registerAdView:self];
    [self.videoSuprAd registerTKMediaView:self];
    [self.videoSuprAd registerPresentingViewController:self.noUseVC];
}

- (void)TKAdSuprAd:(TKAdSuprAd *)suprAd adError:(TKAdError *)error
{
    self.isError = true;
}

- (void)TKMyAppAdSuprAdOnClicked:(TKMyAppAdSuprAd *)ad
{
    
}

- (void)TKAdSuprAdWillLogClick:(TKAdSuprAd *)ad
{
    
}

- (void)TKAdSuprAdWillLogImpression:(TKAdSuprAd *)ad
{
    
}

@end
