//
//  ATAdVideo.h
//  AotterService
//
//  Created by Aotter on 2016/7/12.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@class ATAdVideo;

@protocol ATAdVideoDelegate <NSObject>

@optional
-(void)ATAdVideoReadyToPlay:(ATAdVideo *)ad;;

@optional
-(void)ATAdVideoDidReceiveAd:(ATAdVideo *)ad;

@optional
-(void)ATAdVideoFetchNoAd:(ATAdVideo *)ad;

@optional
-(void)ATAdVideoDidDismissFullScreenMode:(ATAdVideo *)ad;

@optional
-(void)ATAdVideoWillLogImpression:(ATAdVideo *)ad;
                                   
@optional
-(void)ATAdVideoWillLogClicked:(ATAdVideo *)ad;

@end


@interface ATAdVideo : NSObject
@property (nonatomic, weak) id<ATAdVideoDelegate> delegate;
@property NSDictionary *adData;
@property BOOL isReadyToPlay;

-(void)ATinitWithPlace:(NSString *)place;
-(void)ATinitWithPlace:(NSString *)place categories:(NSArray *)categories;

-(void)ATsetVideoContainer:(UIView *)container;
-(void)ATsetTrackingView:(UIView *)trackingView;
-(void)ATsetPresetingViewController:(UIViewController *)viewController;
-(void)ATsetTrackingActionButton:(UIButton *)actionButton;
-(void)ATsetCloseButtonHideTime:(CGFloat)closeButtonHideTime;

-(void)ATfetchAd:(void(^)(NSDictionary *adData))completed;

-(void)ATreleaseAd;

-(void)ATplayVideo;
-(void)ATpauseVideo;

-(void)ATshowFullScreenPlayer;
-(void)ATsetFullScreenPlayerTransition:(UIModalTransitionStyle)style;

-(CGFloat)ATVideoHeightForWidth:(CGFloat)videoContainerWidth;

@end
