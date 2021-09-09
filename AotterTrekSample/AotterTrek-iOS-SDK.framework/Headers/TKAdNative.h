

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TKAdError.h"

@class TKAdNative;
@class TKMyAppAdNative;
@protocol TKAdNativeDelegate <NSObject>

@optional
-(void)TKAdNative:(TKAdNative *)ad didReceivedAdWithData:(NSDictionary *)adData;

@optional
-(void)TKAdNative:(TKAdNative *)ad fetchError:(TKAdError *)error;

@optional
-(void)TKAdNativeWillLogImpression:(TKAdNative *)ad;

@optional
-(void)TKAdNativeWillLogClicked:(TKAdNative *)ad;


/**
 only avaiable for MyApp ads.
 implement this function will prevent default click event(open url)
 */
@optional
-(void)TKMyAppAdNativeOnClicked:(TKMyAppAdNative *)ad;

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
 * Fetch ad.
 * The ad place is required.
 * @param adData ad data
 * @param adError check error.message for more details
 */
-(void)fetchAdWithCallback:(void(^)(NSDictionary *adData, TKAdError *adError))callback;


//check the ad is still valid
-(BOOL)isExpired;

/**
 * Release the ad and its related views, container, and players.
 */
-(void)destroy;


@end


@interface TKMyAppAdNative : TKAdNative

@end


