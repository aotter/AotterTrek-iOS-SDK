

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@class ATAdNative;
@protocol ATAdNativeDelegate <NSObject>

@optional
-(void)ATAdNativeDidReceiveAd:(ATAdNative *)ad;

@optional
-(void)ATAdNativeFetchNoAd:(ATAdNative *)ad;

@optional
-(void)ATAdNativeWillLogImpression:(ATAdNative *)ad;

@optional
-(void)ATAdNativewillLogClicked:(ATAdNative *)ad;
@end



@interface ATAdNative : NSObject
@property NSDictionary *AdData;
@property (nonatomic, weak) id<ATAdNativeDelegate> delegate;

-(void)ATinitWithPlace:(NSString *)place;

-(void)ATsetTrackingView:(UIView *)trackingView;
-(void)ATsetPresnetingViewController:(UIViewController *)viewController;
-(void)ATsetTrackingActionButton:(UIButton *)actionButton;

-(void)ATfetchAd:(void(^)(NSDictionary *adData))completed;

-(void)ATreleaseAd;


@end


