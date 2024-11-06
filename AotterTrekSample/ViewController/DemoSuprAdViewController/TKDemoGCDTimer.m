//
//  TKGCDTimer.m
//  AotterTrekSDK
//
//  Created by Robert on 2023/4/24.
//

#import "TKDemoGCDTimer.h"

@interface TKDemoGCDTimer()

@property (nonatomic, strong) dispatch_queue_t timerQueue;
@property (nonatomic, strong) dispatch_source_t timer;

@end


@implementation TKDemoGCDTimer

- (instancetype)init
{
    self = [super init];
    if (self) {
        dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_USER_INITIATED, 0);
        _timerQueue = dispatch_queue_create("com.TKDemoGCDTimer.queue", attr);
    }
    return self;
}

- (void)scheduledDemoGCDTimerWithTimeInterval:(double)interval
                                        queue:(nullable dispatch_queue_t)queue
                                      repeats:(BOOL)repeats
                                fireInstantly:(BOOL)fireInstantly
                                       action:(dispatch_block_t)dispatchBlock
{
    dispatch_queue_t finalQueue = nil;
    if (queue == nil) {
        finalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    } else {
        finalQueue = queue;
    }
    
    dispatch_barrier_async(self.timerQueue, ^{
        
        if (!self.timer || [self.timer isKindOfClass:[NSNull class]]) {
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, finalQueue);
            dispatch_resume(self.timer);
        }
        
        if (repeats && fireInstantly) {
            dispatch_async(finalQueue, dispatchBlock);
        }
        
        dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.01 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(self.timer, ^{
            
            if (!repeats) {
                dispatch_source_cancel(self.timer);
            }
            
            dispatchBlock();
        });
    });
}

- (void)cancelDemoGCDTimer
{
    dispatch_barrier_async(self.timerQueue, ^{
        
        if (!self.timer || [self.timer isKindOfClass:[NSNull class]]) {
            return;
        }
        dispatch_source_cancel(self.timer);
        
    });
}

@end
