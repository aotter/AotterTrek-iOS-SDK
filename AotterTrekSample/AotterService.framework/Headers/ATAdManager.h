

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ATAdNative.h"
#import "ATAdVideo.h"


//ATAdManager

@interface ATAdManager : NSObject

+(ATAdManager *)sharedAPI;

-(void)ATprefetchAdForPlace:(NSString *)place;
-(void)ATprefetchAdVideoForPlace:(NSString *)place;
-(void)ATsetCacheNumber:(int)num;

-(void)ATclearAllAdCache;
-(void)ATclearAdCacheForPlace:(NSString *)place;
-(void)ATclearAdVideoCacheForPlace:(NSString *)place;

@end
