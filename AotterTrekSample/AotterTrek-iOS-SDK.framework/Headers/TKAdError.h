

#import <Foundation/Foundation.h>

#pragma mark - Ad Error Type

typedef NS_ENUM(NSInteger, TKAdErrorType){
    //Unknown error
    kTKAdErrorType_UNKNOWN,
    
    //Fail with loading or fetching ads.
    kTKAdErrorType_LOADING_ERROR,
    
    //Fail with the ad playing content, or any error occurs in the process.
    kTKAdErrorType_PLAYING_ERROR,
};

#pragma mark - Ad Error Code

typedef NS_ENUM(NSInteger, TKAdErrorCode){
    //Unknown error
    kTKAdError_UNKNOWN_ERROR = 900,
    
    //Trek service is not initialed.
    kTKAdError_TREKSERVICE_NOT_INITIALED = 901,
    
    //MyApp service is not initialed.
    kTKAdError_MYAPPSERVICE_NOT_INITIALED = 902,
    
    //The ad place is required for ad fetching.
    kTKAdError_AD_PLACE_REQURED = 1000,
    
    //The ad TKMediaView is required for ad loading.
    kTKAdError_AD_TKMEDIAVIEW_REQURED = 1001,
    
    //Currently no ad feeds.
    kTKAdError_NO_AD = 800,
    
    //If the ad cache pool is enabled, the first request of the ad will fail immediately.
    kTKAdError_FAILED_BY_CACHE_EANBLED = 801,
    
    //Wrong player type when SuprAd is fetched. It's internal error, please contact us.
    kTKAdError_SUPRAD_UNKNOWN_PLAYERTYPE = 1101,
    
    //Error when VAST video try to fetch/load.
    kTKAdError_SUPRAD_VIDEO_PLAY_ERROR = 1102,
    
};

@interface TKAdError : NSObject

@property (nonatomic, readonly) TKAdErrorType type;

@property (nonatomic, readonly) TKAdErrorCode code;

@property (nonatomic, copy, readonly) NSString *message;

+(TKAdError *)errorWithType:(TKAdErrorType)type code:(TKAdErrorCode)code message:(NSString *)message;
@end

