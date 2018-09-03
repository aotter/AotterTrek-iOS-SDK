//
//  EnumHeaders.h
//  AotterService
//
//  Created by Aotter on 2016/7/19.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ATLoggerLevelNone = 1 << 0,
    ATLoggerLevelNormal = 1 << 2,
    ATLoggerLevelNormalWithXcodeColor = 1 << 3,
    ATLoggerLevelDetail = 1 << 4,
    ATLoggerLevelDetailWithXcodeColor = 1 << 5
}ATLoggerLevel;

typedef enum{
    ATTrackerTypePOST = 1 << 0,
    ATTrackerTypePLACE = 1 << 2,
    ATTrackerTypeGAME = 1 << 3,
    ATTrackerTypeMUSIC = 1 << 4,
    ATTrackerTypeVIDEO = 1 << 5,
    ATTrackerTypeMERCHANT = 1 << 6,
    ATTrackerTypeITEM = 1 << 7
}ATTrackerType;



@interface EnumHeaders : NSObject

@end
