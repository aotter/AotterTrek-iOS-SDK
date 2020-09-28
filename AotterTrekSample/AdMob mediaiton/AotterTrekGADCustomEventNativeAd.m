//
//  AotterTrekGADCustomEventNativeAd.m
//  AotterTrekSample
//
//  Created by Aotter superwave on 2020/8/18.
//  Copyright © 2020 Aotter. All rights reserved.
//

#import "AotterTrekGADCustomEventNativeAd.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>
#import "AotterTrekGADMediatedNativeAd.h"
#import "AotterTrekGADMediatedSuprAd.h"

static NSString *const customEventErrorDomain = @"com.aotter.AotterTrek.GADCustomEvent";

@interface AotterTrekGADCustomEventNativeAd()
@end

@implementation AotterTrekGADCustomEventNativeAd
@synthesize delegate;

-(void)requestNativeAdWithParameter:(NSString *)serverParameter
                            request:(GADCustomEventRequest *)request
                            adTypes:(NSArray *)adTypes
                            options:(NSArray *)options
                 rootViewController:(UIViewController *)rootViewController{
    NSLog(@"[AotterTrekGADCustomEventNativeAd] requestNativeAdWithParamters: %@", serverParameter);
    NSString *errorDescription;
    NSError *jsonError;
    NSDictionary *paramJson;
    if(serverParameter && [serverParameter isKindOfClass:[NSString class]]){
        NSData *objectData = [serverParameter dataUsingEncoding:NSUTF8StringEncoding];
        paramJson = [NSJSONSerialization JSONObjectWithData:objectData
                                              options:NSJSONReadingMutableContainers
                                                error:&jsonError];
    }
    
    if(jsonError || ![paramJson isKindOfClass:[NSDictionary class]] || ![[paramJson allKeys] containsObject:@"adType"]){
        errorDescription = @"You must add AotterTrek adType in Google AdMob CustomEvent protal.";
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorDescription, NSLocalizedFailureReasonErrorKey : errorDescription};
        NSError *error = [NSError errorWithDomain:customEventErrorDomain code:0 userInfo:userInfo];
        [self.delegate customEventNativeAd:self didFailToLoadWithError:error];
        return;
    }
    
    NSString *adType;
    NSString *adPlace = @"";
    adType = [paramJson objectForKey:@"adType"];
    if([[paramJson allKeys] containsObject:@"adPlace"]){
        adPlace = [paramJson objectForKey:@"adPlace"];
    }
    
    if([adType isEqualToString:@"nativeAd"]){
        TKAdNative *adNatve = [[TKAdNative alloc] initWithPlace:adPlace];
        [adNatve fetchAdWithCallback:^(NSDictionary *adData, TKAdError *adError) {
            if(adError){
                NSLog(@"[AotterTrek-iOS-SDK: adMob mediation] TKAdNative fetched Ad error: %@", adError.message);
                NSString *errorDescription = adError.message;
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorDescription, NSLocalizedFailureReasonErrorKey : errorDescription};
                NSError *err = [NSError errorWithDomain:customEventErrorDomain code:0 userInfo:userInfo];
                [self.delegate customEventNativeAd:self didFailToLoadWithError:err];
            }
            else{
                NSLog(@"[AotterTrek-iOS-SDK: adMob mediation] TKAdNative fetched Ad");
                AotterTrekGADMediatedNativeAd *mediatedAd = [[AotterTrekGADMediatedNativeAd alloc] initWithTKNativeAd:adNatve];
                [self.delegate customEventNativeAd:self didReceiveMediatedUnifiedNativeAd:mediatedAd];
            }
        }];
    }
    else if ([adType isEqualToString:@"suprAd"]){
        TKAdSuprAd *suprAd = [[TKAdSuprAd alloc] initWithPlace:adPlace];
        [suprAd fetchAdWithCallback:^(NSDictionary *adData, CGSize preferedAdSize, TKAdError *adError, void (^loadAd)(void)) {
            if(adError){
                NSLog(@"[AotterTrek-iOS-SDK: adMob mediation] TKAdSuprAd fetched Ad error: %@", adError.message);
                NSString *errorDescription = adError.message;
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorDescription, NSLocalizedFailureReasonErrorKey : errorDescription};
                NSError *err = [NSError errorWithDomain:customEventErrorDomain code:0 userInfo:userInfo];
                [self.delegate customEventNativeAd:self didFailToLoadWithError:err];
            }
            else{
                NSLog(@"[AotterTrek-iOS-SDK: adMob mediation] TKAdSuprAd fetched Ad");
                AotterTrekGADMediatedSuprAd *mediatedAd = [[AotterTrekGADMediatedSuprAd alloc] initWithTKSuprAd:suprAd];
                [self.delegate customEventNativeAd:self didReceiveMediatedUnifiedNativeAd:mediatedAd];
            }
        }];
    }
    else{
        NSString *errorDescription = @"invalid ad type for AotterTrek ads";
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorDescription, NSLocalizedFailureReasonErrorKey : errorDescription};
        NSError *err = [NSError errorWithDomain:customEventErrorDomain code:0 userInfo:userInfo];
        [self.delegate customEventNativeAd:self didFailToLoadWithError:err];
    }
    
    
}
    

- (BOOL)handlesUserClicks {
    return YES;
}


- (BOOL)handlesUserImpressions {
    return YES;
}





@end
