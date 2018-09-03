
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "EnumHeaders.h"


#define kATTTypeREAD_POST     @"READ_POST"
#define kATTTypeVISIT_PLACE   @"VISIT_PLACE"
#define kATTTypePLAY_GAME     @"PLAY_GAME"
#define kATTTypeLISTEN_MUSIC  @"LISTEN_MUSIC"
#define kATTTypeWATCH_VIDEO   @"WATCH_VIDEO"
#define kATTTypeCALL_MERCHANT @"CALL_MERCHANT"
#define kATTTypeBUY_ITEM      @"BUY_ITEM"

#define kATEntityTypePOST       @"POST"
#define kATEntityTypePLACE      @"PLACE"
#define kATEntityTypeGAME       @"GAME"
#define kATEntityTypeMUSIC      @"MUSIC"
#define kATEntityTypeVIDEO      @"VIDEO"
#define kATEntityTypeMERCHANT   @"MERCHANT"
#define kATEntityTypeITEM       @"ITEM"

@interface ATTracker : NSObject

+(ATTracker *)sharedAPI;


#pragma mark - engage
/**
 //intiail trakcer item. input nil for no-value parameter.
 @param itemId tracker items' uuid. required
 @param type custom type of trakcer item
 @param userObject set user for this tracker item
 @param entityObject set entity object for this tracker item
 @param locationObject set location object for this tracker item
 */
-(void)ATTrackerEngageItemWithItemId:(NSString *)itemId
                                type:(NSString *)type
                          userObject:(NSDictionary *)userObject
                        entityObject:(NSDictionary *)entityObject
                      locationObject:(NSDictionary *)locationObject;

/**
 //intiail trakcer item. input nil for no-value parameter. auto-generate itemId, if you need record timespan, pleas use engageItemWithItemId: instead.
 @param type custom type of trakcer item
 @param userObject set user for this tracker item
 @param entityObject set entity object for this tracker item
 @param locationObject set location object for this tracker item
 */
-(void)ATTrackerEngageItemWithType:(NSString *)type
                          userObject:(NSDictionary *)userObject
                        entityObject:(NSDictionary *)entityObject
                      locationObject:(NSDictionary *)locationObject;

//delete trakcer item (optional)
-(void)ATTrackerDeleteItem:(NSString *)itemId;

//update tracker item with type (optional)
-(void)ATTrackerUpdateItem:(NSString *)itemId withType:(NSString *)type;

//update tracker item with user object (optional)
-(void)ATTrackerUpdateItem:(NSString *)itemId withUserObject:(NSDictionary *)userObject;

//update trakcer item with entity object (optional)
-(void)ATTrackerUpdateItem:(NSString *)itemId withEntityObject:(NSDictionary *)entityObject;

//update trakcer item with location object (optional)
-(void)ATTrackerUpdateItem:(NSString *)itemId withLocationObject:(NSDictionary *)locationObject;

//add any custom object for trakcer item, only JSON formate support. (optional)
-(void)ATTrackerUpdateItem:(NSString *)itemId withCustomObject:(NSDictionary *)object customObjectKeyName:(NSString *)keyName;

//exit item for record timespan (optional)
-(void)ATTrackerExitItem:(NSString *)itemId;

//send all tracker items
-(void)ATTrackerSendItems;

#pragma mark - Tracker Object Helper

#pragma mark User Object
/**
 engage user for this tracker item.
 @param email string
 @param phone string
 @param fbId string
 @param gender string for "M" or "F"
 @param birthdat DateComponets for birthday
 @param meta anything custom meta
 */
+(NSDictionary *)helper_userObjectWithEmail:(NSString *)email
                                     phone:(NSString *)phone
                                      fbId:(NSString *)fbId
                                    gender:(NSString *)gender
                                  birthday:(NSDateComponents *)birthday
                             addtionalMeta:(NSDictionary *)meta;


#pragma mark Entity Object
/**
 basic entity object with all-custom fields
 @param type kATEntityTypePOST, kATEntityTypePLACE, etc..
 @param entityId uuid of this entity
 @param title sting
 @param url string
 @param tags array of string
 @param categories array of string
 @param meta nsdictionary with JSON
 */
+(NSDictionary *)helper_customEntityObjectWithType:(NSString *)type
                                          entityId:(NSString *)entityId
                                             title:(NSString *)title
                                               url:(NSString *)url
                                              tags:(NSArray *)tags
                                        categories:(NSArray *)categories
                                              meta:(NSDictionary *)meta;
/**
 entity object for entity type == POST
 @param entityId uuid of this entity
 @param title sting
 @param url string
 @param tags array of string
 @param categories array of string
 @param meta nsdictionary with JSON
 @param publishedDate NSDate
 @param imageUrl string
 @param author string
 */
+(NSDictionary *)helper_entityObjectWithTypePOST:(NSString *)entityId
                                           title:(NSString *)title
                                             url:(NSString *)url
                                            tags:(NSArray *)tags
                                      categories:(NSArray *)categories
                                       reference:(NSString *)reference
                                   publishedDate:(NSDate *)publishedDate
                                        imageUrl:(NSString *)imageUrl
                                          author:(NSString *)author
                                            meta:(NSDictionary *)addtionalMeta;

/**
 entity object for entity type == PLACE
 @param entityId uuid of this entity
 @param title sting
 @param url string
 @param tags array of string
 @param categories array of string
 @param meta nsdictionary with JSON
 @param address string
 @param lat double
 @param lng double
 */
+(NSDictionary *)helper_entityObjectWithTypePLACE:(NSString *)entityId
                                           title:(NSString *)title
                                             url:(NSString *)url
                                            tags:(NSArray *)tags
                                       categories:(NSArray *)categories
                                          address:(NSString *)address
                                              lat:(double)lat
                                              lng:(double)lng
                                             meta:(NSDictionary *)addtionalMeta;



#pragma mark Location Object
/**
 @param locationId UUId of location
 @param title
 @param url
 @param categories array of categories, only string avaliable
 @param address
 @param lat 0 for nil
 @param lng 0 for nil
 @param meta additonal custom meta
 */
+(NSDictionary *)helper_locationObjectWithLocationId:(NSString *)locationId
                                         title:(NSString *)title
                                           url:(NSString *)url
                                    categories:(NSArray *)categories
                                       address:(NSString *)address
                                           lat:(double)lat
                                           lng:(double)lng
                                 additonalMeta:(NSDictionary *)meta;



#pragma mark - deprecated
-(void)ATTrackEngageEntityWithId:(NSString *)entityId
                            type:(ATTrackerType)type
                           title:(NSString *)title
                       reference:(NSString *)reference
                             url:(NSString *)url
                        coverImg:(NSString *)coverImg
                   publishedDate:(NSDate *)publishedDate
                      categories:(NSArray *)categories __attribute__((deprecated));
-(void)ATTrackExitEntityWithId:(NSString *)entityId __attribute__((deprecated));
-(void)ATTrackSend __attribute__((deprecated));



@end
