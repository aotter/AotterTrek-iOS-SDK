//
//  AotterTrekNativeCustomEvent.m
//  Aotter_test_mopub_mediation
//
//  Created by Aotter on 2016/12/9.
//  Copyright © 2016年 aotter. All rights reserved.
//

#import "AotterTrekNativeCustomEvent.h"
#import "AotterTrekNativeAdAdapter.h"


@interface AotterTrekNativeCustomEvent()<TKAdNativeDelegate, TKAdSuprAdDelegate>
@property TKAdNative *adNative;
@property TKAdSuprAd *suprAd;
@property AotterTrekNativeAdAdapter *adapter;
@end

@implementation AotterTrekNativeCustomEvent
-(void)requestAdWithCustomEventInfo:(NSDictionary *)info{
    NSString *placeName = info[@"place_name"];
    NSString *type = [NSString stringWithFormat:@"%@", info[@"adType"]];
    NSString *categoryName;
    if(self.localExtras && [self.localExtras.allKeys containsObject:@"category"]){
        categoryName = [NSString stringWithFormat:@"%@", self.localExtras[@"category"]];
    }
    


//    self.adNative = [[TKAdNative alloc] initWithPlace:placeName category:categoryName];
//    self.adNative.delegate = self;
//    [self.adNative fetchAd];
    
    if([type isEqualToString:@"NATIVE_SUPRAD"]){
        self.suprAd = [[TKAdSuprAd alloc] initWithPlace:placeName category:categoryName];
        self.suprAd.delegate = self;
        [self.suprAd fetchAd];
    }
    else{
        self.adNative = [[TKAdNative alloc] initWithPlace:placeName category:categoryName];
        self.adNative.delegate = self;
        [self.adNative fetchAd];
    }
    
}


#pragma mark - TKAdNative delegates

-(void)TKAdNative:(TKAdNative *)ad didReceivedAdWithData:(NSDictionary *)adData{
    if(adData){
        self.adapter = [[AotterTrekNativeAdAdapter alloc] initWithTKNativeAd:self.adNative adProperties:nil];
        MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:self.adapter];
        [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
    }
    else{
        NSError *error = [NSError errorWithDomain:@"com.aotter.aotterTrek" code:100 userInfo:@{@"message": @"fetch no ad"}];
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    }
}

-(void)TKAdNative:(TKAdNative *)ad fetchError:(TKAdError *)error{
    if([self.delegate respondsToSelector:@selector(nativeCustomEvent:didFailToLoadAdWithError:)]){
        NSError *error = [NSError errorWithDomain:@"com.aotter.aotterTrek" code:100 userInfo:@{@"message": @"fetch no ad"}];
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    }
}

-(void)TKAdNativeWillLogImpression:(TKAdNative *)ad{
    if(self.adapter){
        [self.adapter onLogImression];
    }
}


#pragma mark - TKAdSuprAd delegates

-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferedMediaViewSize:(CGSize)size{
    if(adData){
        self.adapter = [[AotterTrekNativeAdAdapter alloc] initWithTKSuprAd:self.suprAd adProperties:nil];
        [self.suprAd registerTKMediaView:self.adapter.mainMediaView];
        MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:self.adapter];
        [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
    }
}


-(void)TKAdSuprAdCompleted:(TKAdSuprAd *)suprAd{
    
}

-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd adError:(TKAdError *)error{
    
}






@end
