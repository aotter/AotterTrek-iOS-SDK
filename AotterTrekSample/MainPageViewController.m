//
//  MainPageViewController.m
//  AotterTrekSample
//
//  Created by Aotter on 2016/8/3.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "MainPageViewController.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>
#import "DemoNativeAdViewController.h"
#import "DemoSuprAdViewController.h"
#import "DemoBannerAdViewController.h"

@interface MainPageViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *mainStackView;

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurUI];
    
    NSString *birthday = @"1956/01/25";
    
    [[AotterTrek sharedAPI]setCurrentUserWithEmail:@"testUser@mail.com" phone:@"" fbId:@"" gender:@"male" birthday:birthday addtionalMeta:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
-(void)configurUI{
    UIButton *nativeAdButton = [[UIButton alloc] init];
    [nativeAdButton setTitle:@"Native Ad sample" forState:UIControlStateNormal];
    [nativeAdButton addTarget:self action:@selector(buttonClickDemoNativeAd:) forControlEvents:UIControlEventTouchUpInside];
    [nativeAdButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainStackView addArrangedSubview:nativeAdButton];
    
    UIButton *suprAdButton = [[UIButton alloc] init];
    [suprAdButton setTitle:@"Supr Ad sample" forState:UIControlStateNormal];
    [suprAdButton addTarget:self action:@selector(buttonClickDemoSuprAd:) forControlEvents:UIControlEventTouchUpInside];
    [suprAdButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainStackView addArrangedSubview:suprAdButton];
    
    UIButton *bannerAdButton = [[UIButton alloc] init];
    [bannerAdButton setTitle:@"Banner Ad sample" forState:UIControlStateNormal];
    [bannerAdButton addTarget:self action:@selector(buttonClickDemoBannerAd:) forControlEvents:UIControlEventTouchUpInside];
    [bannerAdButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainStackView addArrangedSubview:bannerAdButton];
    
//    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
//    [self.view setNeedsUpdateConstraints];
//    [self.view updateConstraints];
}

#pragma mark - Button action

-(IBAction)buttonClickDemoNativeAd:(id)sender{
    DemoNativeAdViewController *vc = [[DemoNativeAdViewController alloc] init];
    [self presentVC:vc];
}

-(IBAction)buttonClickDemoSuprAd:(id)sender{
    DemoSuprAdViewController *vc = [[DemoSuprAdViewController alloc] init];
    [self presentVC:vc];
}

-(IBAction)buttonClickDemoBannerAd:(id)sender{
    DemoBannerAdViewController *vc = [[DemoBannerAdViewController alloc] init];
    [self presentVC:vc];
}

#pragma mark - Private Method

- (void)presentVC:(UIViewController *)vc {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
