

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TKAdError.h"

@class TKAdNative;
@protocol TKAdNativeDelegate <NSObject>

@optional
-(void)TKAdNative:(TKAdNative *)ad didReceivedAdWithData:(NSDictionary *)adData;

@optional
-(void)TKAdNative:(TKAdNative *)ad fetchError:(TKAdError *)error;

@optional
-(void)TKAdNativeOnImpression:(TKAdNative *)ad;

@optional
-(void)TKAdNativeOnClicked:(TKAdNative *)ad;
@end



@interface TKAdNative : NSObject
@property NSDictionary *AdData;
@property (nonatomic, weak) id<TKAdNativeDelegate> delegate;


/**
 * Initialize the NativeAd with ad place.
 * @param place ad place.
 */
-(instancetype)initWithPlace:(NSString *)place;

/**
 * Initialize the NativeAd with ad place and ad category
 @param place    ad place.
 @param category ad cateogry
 */
-(instancetype)initWithPlace:(NSString *)place category:(NSString *)category;


/**
 * Register Ad view for view checking, etc..
 */
-(void)registerAdView:(UIView *)adView;


/**
 * Register the viewcontroller for view showing.
 *
 * WARNING: If this is not set, the top viewcontroller on main window will be used.
 * @param  viewController  the viewControlelr for presenting additonal views
 */
-(void)registerPresentingViewController:(UIViewController *)viewController;


/**
 * Register the button for call-to-action event
 */
-(void)registerCallToActionButton:(UIButton *)actionButton;


/**
 * Fetch ad.
 * The ad place is required.
 * TKAdNative: didReceivedAdWithData: or TKAdNative: fetchError: will get called after fetching the ad.
 */
-(void)fetchAd;


/**
 * Release the ad and its related views, container, and players.
 */
-(void)destroy;


@end

