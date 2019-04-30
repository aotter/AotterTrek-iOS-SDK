

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ATAdNative.h"
#import "ATAdVideo.h"


//ATAdManager

@interface ATAdManager : NSObject

+(ATAdManager *)sharedAPI;

#pragma mark - prefetch functions
-(void)ATprefetchAdForPlace:(NSString *)place DEPRECATED_MSG_ATTRIBUTE("please use ATprefetchNativeAdForPlace:");
-(void)ATprefetchAdVideoForPlace:(NSString *)place DEPRECATED_MSG_ATTRIBUTE("please use ATprefetchVideoAdForPlace:");
-(void)ATprefetchNativeAdForPlace:(NSString *)place;
-(void)ATprefetchNativeAdForPlace:(NSString *)place categories:(NSArray *)categories;
-(void)ATprefetchVideoAdForPlace:(NSString *)place;
-(void)ATprefetchVideoAdForPlace:(NSString *)place categories:(NSArray *)categories;
-(void)ATprefetchInteractAdForPlace:(NSString *)place;
-(void)ATprefetchInteractAdForPlace:(NSString *)place categories:(NSArray *)categories;

#pragma mark - Cache Pool Size
-(void)ATsetCacheNumber:(int)num DEPRECATED_MSG_ATTRIBUTE("please use ATsetIndivisualAdPoolSize:");

/**
 the indisvisual size show how many cache items could remains in cache for indiviual ad unit.
 */
-(void)ATsetIndividualAdPoolSize:(int)indivisualSize;




#pragma mark - clean Cache
-(void)ATclearAllAdCache;
-(void)ATclearAdCacheForPlace:(NSString *)place DEPRECATED_MSG_ATTRIBUTE("please use ATclearCacheForNativeAdWithPlace:");
-(void)ATclearAdVideoCacheForPlace:(NSString *)place DEPRECATED_MSG_ATTRIBUTE("please use ATclearCacheForVideoAdWithPlace:");;
-(void)ATclearCacheForNativeAdWithPlace:(NSString *)place;
-(void)ATclearCacheForNativeAdWithPlace:(NSString *)place categories:(NSArray *)categories;
-(void)ATclearCacheForVideoAdWithPlace:(NSString *)place;
-(void)ATclearCacheForVideoAdWithPlace:(NSString *)place categories:(NSArray *)categories;
-(void)ATclearCacheForInteractAdWithPlace:(NSString *)place;
-(void)ATclearCacheForInteractAdWithPlace:(NSString *)place categories:(NSArray *)categories;

@end
