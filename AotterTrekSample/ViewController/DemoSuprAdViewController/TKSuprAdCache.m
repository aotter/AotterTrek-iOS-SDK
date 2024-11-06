//
//  TKSuprAdCache.m
//  AotterTrekSample
//
//  Created by Robert on 2024/11/6.
//  Copyright © 2024 Aotter. All rights reserved.
//

#import "TKSuprAdCache.h"

@interface TKSuprAdCache () <TKAdSuprAdDelegate>

@property (atomic, strong) NSMutableArray *dataList;

@end

@implementation TKSuprAdCache

+ (instancetype) sharedInstance
{
    static TKSuprAdCache *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TKSuprAdCache alloc] init];
        instance.dataList = [[NSMutableArray alloc] init];
        [instance makeSuprAdViewContainer];
    });
    return instance;
}

- (TKSuprAdViewContainer *)getSuprAdViewContainer
{
    @synchronized (self.dataList) {
        TKSuprAdViewContainer *viewObj = nil;
        if (self.dataList.count != 0) {
            viewObj = self.dataList.firstObject;
            [self.dataList removeObjectAtIndex:0];
        }
        if (self.dataList.count == 0) {
            [self makeSuprAdViewContainer];
        }
        return viewObj;
    }
}

- (void)makeSuprAdViewContainer
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        TKSuprAdViewContainer *view = [[TKSuprAdViewContainer alloc] init];
        @synchronized (strongSelf.dataList) {
            [strongSelf.dataList addObject:view];
        }
        
    });}

@end
