//
//  DemoBannerAdViewController.m
//  AotterTrekSample
//
//  Created by JustinTsou on 2021/3/31.
//  Copyright © 2021 Aotter. All rights reserved.
//

#import "DemoBannerAdViewController.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>

@interface DemoBannerAdViewController ()<TKAdSuprAdDelegate>
{
    UIView *_suprAdView;
    CGFloat _viewWidth;
    CGFloat _viewHeight;
}

@property (nonatomic,strong) TKAdSuprAd *suprAd;
@end

@implementation DemoBannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    self.adTypeLabel.text = @"Banned Ad Sample";
    
    [self fetchSuprAd];
}


-(IBAction)done:(id)sender{
    [self.suprAd destroy];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark : fetch TKAdSuprAd

- (void)fetchSuprAd {
    
    if(!self.suprAd){
        self.suprAd = [[TKAdSuprAd alloc] initWithPlace:@"banner"];
    }
    self.suprAd.delegate = self;
    [self.suprAd registerPresentingViewController:self];
    
    [self.suprAd fetchAd];
}

#pragma mark : SuprAd delegate

- (void)TKAdSuprAdCompleted:(TKAdSuprAd *)suprAd{
    NSLog(@"TKAdSuprAd >> Completed");
}

- (void)TKAdSuprAd:(TKAdSuprAd *)suprAd adError:(TKAdError *)error{
    NSLog(@"TKAdSuprAd >> adError: %@", error.message);
}

- (void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferedMediaViewSize:(CGSize)size {
    
    self.suprAd = suprAd;
    
    _viewWidth = UIScreen.mainScreen.bounds.size.width;
    _viewHeight = _viewWidth * size.height/size.width;
    int height = (int)_viewHeight;
    _suprAdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewWidth, height)];
    
    [self.suprAd registerAdView:_suprAdView];
    [self.suprAd registerTKMediaView:_suprAdView];
    
    [self.view addSubview:_suprAdView];
    
    [_suprAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_suprAdView.widthAnchor constraintEqualToConstant:_viewWidth].active = YES;
    [_suprAdView.heightAnchor constraintEqualToConstant:height].active = YES;
    
    if (@available(iOS 11.0, *)) {
        [_suprAdView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    } else {
        [_suprAdView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    }
}

@end
