//
//  TKSuprAdCache.h
//  AotterTrekSample
//
//  Created by Robert on 2024/11/6.
//  Copyright © 2024 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKSuprAdViewContainer.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKSuprAdCache : NSObject

+ (instancetype) sharedInstance;
- (TKSuprAdViewContainer *)getSuprAdViewContainer;

@end

NS_ASSUME_NONNULL_END
