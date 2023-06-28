//
//  AdmobBannerAdDemoVC.m
//  AotterTrekSample
//
//  Created by Robert on 2023/6/19.
//  Copyright © 2023 Aotter. All rights reserved.
//

#import "AdmobBannerAdDemoVC.h"
#import <Masonry/Masonry.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#warning: set your UUID
static NSString *const TestBannerAdUnit = @"set your UUID";

@interface AdmobBannerAdDemoVC () <GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *gadBannerView;
@property (nonatomic, strong) GADBannerView *tempAdView;
@property (nonatomic, strong) UIButton *buttonRefresh;

@end

@implementation AdmobBannerAdDemoVC


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUILayout];
}

- (void)initUILayout
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.buttonRefresh = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Refresh" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonRefreshClicked:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:self.buttonRefresh];
    [self.buttonRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
    [self setupGADAdLoader];
}


#pragma mark - Button Method

- (void)buttonRefreshClicked:(UIButton *)button
{
    NSLog(@"buttonRefreshClicked");
    [self setupAndLoadGADRequest];
}


#pragma mark - Setup GADAdLoader

- (void)setupGADAdLoader
{
    self.gadBannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeBanner];
    self.gadBannerView.delegate = self;
    self.gadBannerView.rootViewController = self;
    self.gadBannerView.adUnitID = TestBannerAdUnit;
    
    [self setupAndLoadGADRequest];
}

- (void)setupAndLoadGADRequest
{
    GADRequest *request = [GADRequest request];

//    GADExtras *extras = [[GADExtras alloc] init];
//    [extras setAdditionalParameters:@{@"foo" : @"bar"}];
//    [request registerAdNetworkExtras:extras];

    GADCustomEventExtras *extra = [[GADCustomEventExtras alloc] init];

    /**
     AotterTrekGADCustomEventNativeAd for v8 below
     AotterTrekGADMediaAdapter for v9 above
     */
    [extra setExtras:@{
                        @"category"      :   @"banner_movie"
                     }
            forLabel:@"AotterTrekGADMediaAdapter"]; //AotterTrekGADCustomEventNativeAd
    [request registerAdNetworkExtras:extra];

    NSLog(@"[AdmobBannerAdDemoVC] ready to load request: %@", request);
    [self.gadBannerView loadRequest:request];
}

- (void)setupBannerViewUI:(GADBannerView *)bannerView
{
    [self.tempAdView removeFromSuperview];
    self.tempAdView = bannerView;
    [self.view addSubview:self.tempAdView];
    [self.tempAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(bannerView.bounds.size.height);
    }];
    [self.view setNeedsDisplay];
}


#pragma mark - GADBannerViewDelegate

- (void)bannerViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"bannerViewDidReceiveAd");
    if (bannerView != nil) {
        [self setupBannerViewUI:bannerView];
    }
}

- (void)bannerView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"error message: %@",error.localizedDescription);
}

@end
