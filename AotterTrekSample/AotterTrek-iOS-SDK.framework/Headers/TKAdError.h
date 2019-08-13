

#import <Foundation/Foundation.h>

#pragma mark - ATSuprAdErrorType

typedef NS_ENUM(NSInteger, TKAdErrorType){
    //Unknown error
    kTKAdErrorType_UNKNOWN,
    
    //Fail with loading or fetching ads.
    kTKAdErrorType_LOADING_ERROR,
    
    //Fail with the ad playing content, or any error occurs in the process.
    kTKAdErrorType_PLAYING_ERROR,
};

#pragma mark - ATSuprAdErrorCode

typedef NS_ENUM(NSInteger, TKAdErrorCode){
    //Unknown error
    kTKAdError_UNKNOWN_ERROR = 900,
    
    //Wrong player type when SuprAd is fetched. It's internal error, please contact us.
    kTKAdError_UNKNOWN_PLAYERTYPE = 901,
    
    //The ad place is required for ad fetching.
    kTKAdError_AD_PLACE_REQURED = 1000,
    
    //The ad TKMediaView is required for ad loading.
    kTKAdError_AD_TKMEDIAVIEW_REQURED = 1001,
    
    //Currently no ad feeds.
    kTKAdError_NO_AD = 800,
    
    //If the ad cache pool is enabled, the first request of the ad will fail immediately.
    kTKAdError_FAILED_BY_CACHE_EANBLED = 801,
    
    
};

@interface TKAdError : NSObject

@property (nonatomic, readonly) TKAdErrorType type;

@property (nonatomic, readonly) TKAdErrorCode code;

@property (nonatomic, copy, readonly) NSString *message;

+(TKAdError *)errorWithType:(TKAdErrorType)type code:(TKAdErrorCode)code message:(NSString *)message;
@end

