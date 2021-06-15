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
        // "place":"banner","uuid":"669bad6a-27ec-487a-a583-7b5305732ff7"
        self.suprAd = [[TKAdSuprAd alloc] initWithPlace:@"669bad6a-27ec-487a-a583-7b5305732ff7"];
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
    
    _suprAdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    [self.suprAd registerAdView:_suprAdView];
    [self.suprAd registerTKMediaView:_suprAdView];
    
    [self.view addSubview:_suprAdView];
    
    [_suprAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_suprAdView.widthAnchor constraintEqualToConstant:size.width].active = YES;
    [_suprAdView.heightAnchor constraintEqualToConstant:size.height].active = YES;
    [_suprAdView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    if (@available(iOS 11.0, *)) {
        [_suprAdView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    } else {
        [_suprAdView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    }
}

@end
