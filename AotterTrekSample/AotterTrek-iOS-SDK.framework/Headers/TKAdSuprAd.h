//
//  ATSuprAd.h
//  AotterService
//
//  Created by Aotter superwave on 2019/7/30.
//  Copyright © 2019 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TKAdError.h"

@class TKAdSuprAd;
@protocol TKAdSuprAdDelegate <NSObject>


/**
 * Tell when the SuprAd fetch fails.
 * check error.message for more details.
 */
@optional
-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd fetchError:(TKAdError *)error;



/**
 * While the SuprAd finishes fetching the ad, it will return prefered ad size.
 * Developer could set adContainer and presentingViewController in this callback.
 *
 * WARNING: If you implement it, you should call SuprAd.loadAd() manually.
 * @param  size    preferred media view size for this ad.
 * @param  adData  ad data
 */
@optional
-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferecdMediaViewSize:(CGSize)size;



/**
 * Tell when the SuprAd finishes loading and the ad is ready to display on screen.
 */
@optional
-(void)TKAdSuprAdDidLoaded:(TKAdSuprAd *)suprAd;



/**
 * Tell when the SuprAd loading fails.
 * check error.message for more details.
 */
@optional
-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd loadError:(TKAdError *)error;

@end


@interface TKAdSuprAd : NSObject
@property (weak) id<TKAdSuprAdDelegate> delegate;
@property (readonly) NSDictionary *adData;
@property (readonly) BOOL adLoaded;
@property (readonly) CGSize preferedContainerSize;

/**
 * Initialize the SuperAd with ad place.
 * @param place ad place.
 */
-(instancetype)initWithPlace:(NSString *)place;

/**
 * Initialize the SuperAd with ad place and ad category
 @param place    ad place.
 @param category ad cateogry
 */
-(instancetype)initWithPlace:(NSString *)place category:(NSString *)category;

/**
 * Set the ad category manually.
 * @param category ad category
 */
-(void)setAdCategory:(NSString *)category;


/**
 * Register Ad view for view checking.
 * adView and TKMediaView could be the same.
 */
-(void)registerAdView:(UIView *)adView;



/**
 * Register ad media view for SuprAd view displaying.
 * adView and TKMediaView could be the same.
 */
-(void)registerTKMediaView:(UIView *)adMediaView;


/**
 * Register the viewcontroller for view showing.
 * 
 * WARNING: If this is not set, the top viewcontroller on main window will be used.
 * @param  viewController  the viewControlelr for presenting additonal views
 */
-(void)registerPresentingViewController:(UIViewController *)viewController;


/**
 * Fetch suprAd.
 * The ad place is required.
 * TKSuprAd:didReceiveAdWithSize: or TKSuprAd:fetchFailed: will get called after fetching the ad.
 */
-(void)fetchAd;

/**
 * Load ad content. 
 * When the ad loading is completed. TKSuprAdDidLoaded: will get called.
 *
 * IMPORTANT: the AdContainer is required before calling this method.
 * IMPORTANT: if TKSuprAd:didReceiveAdWithSize: is not implemented, the SuprAd.loadAd() will automatically be triggered after fetching the ad completely.
 */
-(void)loadAd;



/**
 * Release the ad and its related views, container, and players.
 */
-(void)destroy;

@end
