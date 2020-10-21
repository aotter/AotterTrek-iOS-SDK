

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TKAdNative.h"



@interface TKAdManager : NSObject

+(TKAdManager *)sharedAPI;

#pragma mark - prefetch functions
/**
 * Prefetch TKNativeAd with specific ad place.
 * @param place  ad place
 */
-(void)prefetchNativeAdForPlace:(NSString *)place DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");

/**
 * Prefetch TKNativeAd with specific ad place and ad category.
 * @param place     ad place
 * @param category  ad category
 */
-(void)prefetchNativeAdForPlace:(NSString *)place category:(NSString *)category DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");

/**
 * Prefetch TKSuprAd with specific ad place and ad category
 * @param place     ad place
 */
-(void)prefetchSuprAdForPlace:(NSString *)place DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");

/**
 * Prefetch TKSuprAd with specific ad place and ad category
 @param place     ad place
 @param category  ad category
 */
-(void)prefetchSuprAdForPlace:(NSString *)place category:(NSString *)category DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");



#pragma mark - clean Cache
/**
 * Clear all cache pool's cache
 */
-(void)clearAllAdCache DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");

/**
 * Clear cache for all TKNativeAd with specific ad place.
 @param  place   ad place
 */
-(void)clearCacheForNativeAdWithPlace:(NSString *)place DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");

/**
 * Clear cache for all TKNativeAd with specific ad place and ad category.
 @param place     ad place
 @param category  ad category
 */
-(void)clearCacheForNativeAdWithPlace:(NSString *)place category:(NSString *)category DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");

/**
 * Clear cache for all TKSuprAd with specific ad place.
 @param place     ad place
 */
-(void)clearCahceForSuprAdWithPlace:(NSString *)place DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");

/**
 * Clear cache for all TKSuprAd with specific ad place and ad category.
 @param place     ad place
 @param category  ad category
 */
-(void)clearCahceForSuprAdWithPlace:(NSString *)place category:(NSString *)category DEPRECATED_MSG_ATTRIBUTE("Cache pool deprecated after 3.5.0");
@end
