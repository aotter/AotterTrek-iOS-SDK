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
@class TKMyAppAdSuprAd;
@protocol TKAdSuprAdDelegate <NSObject>



/**
 * While the SuprAd finishes fetching the ad, it will return prefered ad size.
 * Developer could set adContainer and presentingViewController in this callback.
 *
 * @param  size    preferred media view size for this ad.
 * @param  adData  ad data
 */
@optional
-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferedMediaViewSize:(CGSize)size;

/**
 * While the SuprAd finishes fetching the ad, it will return prefered ad size.
 * Developer could set adContainer and presentingViewController in this callback.
 *
 * @param  size        preferred media view size for this ad.
 * @param  adData      ad data
 * @param  isVideoAd   determine this suprAd is video type or not
 */
@optional
-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferedMediaViewSize:(CGSize)size isVideoAd:(BOOL)isVideoAd;



/**
 * Tell when the SuprAd finishes loading and the ad is ready to display on screen.
 */
@optional
-(void)TKAdSuprAdCompleted:(TKAdSuprAd *)suprAd;



/**
 * Tell when the SuprAd get error when fetching/loading.
 * check error.message for more details.
 */
@optional
-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd adError:(TKAdError *)error;


/**
 only avaiable for MyApp ads.
 implement this function will prevent default click event(open url)
 */
@optional
-(void)TKMyAppAdSuprAdOnClicked:(TKMyAppAdSuprAd *)ad;


/**
 * only available for non-video type ad
 * check Video type through isVideoAd function
 */
@optional
-(void)TKAdSuprAdWillLogImpression:(TKAdSuprAd *)ad;

/**
 * only available for non-video type ad
 * check Video type through isVideoAd function
 */
@optional
-(void)TKAdSuprAdWillLogClick:(TKAdSuprAd *)ad;


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
-(void)registerTKMediaView:(UIView *)tkMediaView;


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
 * TKSuprAd:didReceiveAdWithSize: or TKSuprAd:adError: will get called after fetching the ad.
 */
-(void)fetchAd;


/*
  no doc.
 */
-(void)loadAd;



/**
 * Fetch suprAd.
 * The ad place is required.
 * @param adData ad data
 * @param preferedAdSize preferred media view size for this ad.
 * @param adError check error.message for more details
 * @param loadAd implement this method when your ad settings done. If not implement this method, the ad will not going to load.
 */
-(void)fetchAdWithCallback:(void(^)(NSDictionary *adData, CGSize preferedAdSize, TKAdError *adError, BOOL isVideoAd, void(^loadAd)(void)))callback;


//check the ad is still valid
-(BOOL)isExpired;

//check this supr ad is video type
-(BOOL)isVideoAd;


/**
 * Release the ad and its related views, container, and players.
 */
-(void)destroy;


/**
    if you render the ad in your scrollView/TableView/CollectionView or anything may have vertical scroll behavior, please call this fuction when the scrollView scrolled.
    such as -(void)scrollViewDidScroll:(UIScrollView *)scrollView;
 */
-(void)notifyAdScrolled;

@end


@interface TKMyAppAdSuprAd : TKAdSuprAd

@end
