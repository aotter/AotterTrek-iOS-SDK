//
//  TKGCDTimer.h
//  AotterTrekSDK
//
//  Created by Robert on 2023/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKDemoGCDTimer : NSObject

- (void)scheduledDemoGCDTimerWithTimeInterval:(double)interval
                                        queue:(nullable dispatch_queue_t)queue
                                      repeats:(BOOL)repeats
                                fireInstantly:(BOOL)fireInstantly
                                       action:(dispatch_block_t)dispatchBlock;
- (void)cancelDemoGCDTimer;

@end

NS_ASSUME_NONNULL_END
