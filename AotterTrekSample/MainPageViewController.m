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
#import "DemoAdMobMedationNativeAdViewController.h"

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
    
    UIButton *adMobMedaionBtn = [[UIButton alloc] init];
    [adMobMedaionBtn setTitle:@"AdMob(google) mediation sample" forState:UIControlStateNormal];
    [adMobMedaionBtn addTarget:self action:@selector(buttonClickDemoAdMobMediaion:) forControlEvents:UIControlEventTouchUpInside];
    [adMobMedaionBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainStackView addArrangedSubview:adMobMedaionBtn];
    
//    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
//    [self.view setNeedsUpdateConstraints];
//    [self.view updateConstraints];
}

#pragma mark - Button action

-(IBAction)buttonClickDemoNativeAd:(id)sender{
    DemoNativeAdViewController *vc = [[DemoNativeAdViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

-(IBAction)buttonClickDemoSuprAd:(id)sender{
    DemoSuprAdViewController *vc = [[DemoSuprAdViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

-(IBAction)buttonClickDemoAdMobMediaion:(id)sender{
    DemoAdMobMedationNativeAdViewController *vc = [[DemoAdMobMedationNativeAdViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
