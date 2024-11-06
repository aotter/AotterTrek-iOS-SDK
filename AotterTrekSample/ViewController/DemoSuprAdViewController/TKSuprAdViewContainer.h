//
//  TKSuprAdViewContainer.h
//  AotterTrekSample
//
//  Created by Robert on 2024/11/6.
//  Copyright © 2024 Aotter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKSuprAdViewContainer : UIView

@property (nonatomic, strong) TKAdSuprAd *videoSuprAd;
@property (nonatomic, assign) BOOL isCompleted;
@property (nonatomic, assign) BOOL isError;

@end

NS_ASSUME_NONNULL_END
