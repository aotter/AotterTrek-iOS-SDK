
#import <Foundation/Foundation.h>




typedef enum {
    //no logs will shown
    TKLoggerLevelNone = 1 << 0,
    
    //nessary logs or warning/error logs will shown
    TKLoggerLevelNormal = 1 << 2,
    
    //all logs include verbose logs will shown
    TKLoggerLevelDetail = 1 << 3,
    
}TKLoggerLevel;



typedef enum{
    TKTrackerTypePOST = 1 << 0,
    TKTrackerTypePLACE = 1 << 2,
    TKTrackerTypeGAME = 1 << 3,
    TKTrackerTypeMUSIC = 1 << 4,
    TKTrackerTypeVIDEO = 1 << 5,
    TKTrackerTypeMERCHANT = 1 << 6,
    TKTrackerTypeITEM = 1 << 7
}TKTrackerType;



@interface TKEnumHeaders : NSObject

@end
