//
//  AotterTrekNativeCustomEvent.h
//  Aotter_test_mopub_mediation
//
//  Created by Aotter on 2016/12/9.
//  Copyright © 2016年 aotter. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPNativeCustomEvent.h"
    #import "MPNativeAd.h"
#endif



#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>

@interface AotterTrekNativeCustomEvent : MPNativeCustomEvent<TKAdNativeDelegate>

@end
