
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "EnumHeaders.h"



@interface ATTracker : NSObject

+(ATTracker *)sharedAPI;

-(void)ATTrackEngageEntityWithId:(NSString *)entityId
                           title:(NSString *)title
                       reference:(NSString *)reference
                             url:(NSString *)url
                        coverImg:(NSString *)coverImg
                   publishedDate:(NSDate *)publishedDate
                      categories:(NSArray *)categories;


-(void)ATTrackExitEntityWithId:(NSString *)entityId;

-(void)ATTrackSend;

@end
