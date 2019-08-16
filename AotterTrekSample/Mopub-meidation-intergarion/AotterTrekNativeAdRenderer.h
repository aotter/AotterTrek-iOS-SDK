//
//  AotterTrekNativeAdRenderer.h
//  Aotter_pnn6ios
//
//  Created by Aotter superwave on 2019/8/15.
//  Copyright © 2019 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPNativeAdRenderer.h"
    #import "MPNativeAdRendererConfiguration.h"
#endif



@interface AotterTrekNativeAdRenderer : NSObject<MPNativeAdRenderer>
@property (nonatomic, readonly) MPNativeViewSizeHandler viewSizeHandler;
+ (MPNativeAdRendererConfiguration *)rendererConfigurationWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings;
@end


