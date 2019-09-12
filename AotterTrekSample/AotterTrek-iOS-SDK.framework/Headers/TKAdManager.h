

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
-(void)prefetchNativeAdForPlace:(NSString *)place;

/**
 * Prefetch TKNativeAd with specific ad place and ad category.
 * @param place     ad place
 * @param category  ad category
 */
-(void)prefetchNativeAdForPlace:(NSString *)place category:(NSString *)category;

/**
 * Prefetch TKSuprAd with specific ad place and ad category
 * @param place     ad place
 */
-(void)prefetchSuprAdForPlace:(NSString *)place;

/**
 * Prefetch TKSuprAd with specific ad place and ad category
 @param place     ad place
 @param category  ad category
 */
-(void)prefetchSuprAdForPlace:(NSString *)place category:(NSString *)category;;

#pragma mark - Cache Pool Size
/**
 * Disable cache pool, all ad fetching events will take some time to get callback.
 */
-(void)disableAdCachePool;

/**
 * Enable cache pool for saving ads into local memory.
 @param size   pool size for every ad key 1~10
 */
-(void)enableAdCachePoolWithIndiviaulPoolSize:(int)size;


#pragma mark - clean Cache
/**
 * Clear all cache pool's cache
 */
-(void)clearAllAdCache;

/**
 * Clear cache for all TKNativeAd with specific ad place.
 @param  place   ad place
 */
-(void)clearCacheForNativeAdWithPlace:(NSString *)place;

/**
 * Clear cache for all TKNativeAd with specific ad place and ad category.
 @param place     ad place
 @param category  ad category
 */
-(void)clearCacheForNativeAdWithPlace:(NSString *)place category:(NSString *)category;

/**
 * Clear cache for all TKSuprAd with specific ad place.
 @param place     ad place
 */
-(void)clearCahceForSuprAdWithPlace:(NSString *)place;

/**
 * Clear cache for all TKSuprAd with specific ad place and ad category.
 @param place     ad place
 @param category  ad category
 */
-(void)clearCahceForSuprAdWithPlace:(NSString *)place category:(NSString *)category;;
@end
