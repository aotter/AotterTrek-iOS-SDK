//
//  ATInteractAd.h
//  AotterService
//
//  Created by Aotter superwave on 2017/9/27.
//  Copyright © 2017年 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@class ATInteractAd;

@protocol ATInteractAdDelegate<NSObject>

@optional
-(void)ATInteractAdFetchNoAd:(ATInteractAd *)ad;

-(void)ATInteractAdLoaded:(ATInteractAd *)ad;

-(void)ATInteractAdViewLoadCompleted:(ATInteractAd *)ad;

-(void)ATInteractAdWillLogImpression:(ATInteractAd *)ad;

-(void)ATInteractAdWillLogClicked:(ATInteractAd *)ad;

@end


@interface ATInteractAd : NSObject
@property NSDictionary *adData;
@property BOOL isAdLoaded;
@property BOOL isAdCompleted;

@property (nonatomic, weak) id<ATInteractAdDelegate> delegate;

-(void)ATinitWithPlace:(NSString *)place;

-(void)ATsetTrackingView:(UIView *)trackingView;
-(void)ATsetInteractAdContainer:(UIView *)container;

-(void)ATsetPresetingViewController:(UIViewController *)viewController;
-(void)ATfetchAd:(void(^)(NSDictionary *adData))completed;
-(void)ATreleaseAd;

-(void)ATReloadInteractView;
-(void)ATSetMediaBackgroundBlack:(BOOL)isBlack;

-(CGFloat)AdHeightWithWidth:(CGFloat)width;
@end



