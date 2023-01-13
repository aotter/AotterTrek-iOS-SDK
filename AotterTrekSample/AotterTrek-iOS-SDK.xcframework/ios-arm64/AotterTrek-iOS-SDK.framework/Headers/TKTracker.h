
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "TKEnumHeaders.h"


#define kTKTTypeREAD_POST     @"READ_POST"
#define kTKTTypeVISIT_PLACE   @"VISIT_PLACE"
#define kTKTTypePLAY_GAME     @"PLAY_GAME"
#define kTKTTypeLISTEN_MUSIC  @"LISTEN_MUSIC"
#define kTKTTypeWATCH_VIDEO   @"WATCH_VIDEO"
#define kTKTTypeCALL_MERCHANT @"CALL_MERCHANT"
#define kTKTTypeBUY_ITEM      @"BUY_ITEM"

#define kTKEntityTypePOST       @"POST"
#define kTKEntityTypePLACE      @"PLACE"
#define kTKEntityTypeGAME       @"GAME"
#define kTKEntityTypeMUSIC      @"MUSIC"
#define kTKEntityTypeVIDEO      @"VIDEO"
#define kTKEntityTypeMERCHANT   @"MERCHANT"
#define kTKEntityTypeITEM       @"ITEM"

@interface TKTracker : NSObject

+(TKTracker *)sharedAPI;


#pragma mark - engage
/**
 //intiail trakcer item. input nil for no-value parameter.
 @param itemId tracker items' uuid. required
 @param type custom type of trakcer item
 @param userObject set user for this tracker item
 @param entityObject set entity object for this tracker item
 @param locationObject set location object for this tracker item
 */
-(void)trackerEngageItemWithItemId:(NSString *)itemId
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
-(void)trackerEngageItemWithType:(NSString *)type
                          userObject:(NSDictionary *)userObject
                        entityObject:(NSDictionary *)entityObject
                      locationObject:(NSDictionary *)locationObject;

//delete trakcer item (optional)
-(void)trackerDeleteItem:(NSString *)itemId;

//update tracker item with type (optional)
-(void)trackerUpdateItem:(NSString *)itemId withType:(NSString *)type;

//update tracker item with user object (optional)
-(void)trackerUpdateItem:(NSString *)itemId withUserObject:(NSDictionary *)userObject;

//update trakcer item with entity object (optional)
-(void)trackerUpdateItem:(NSString *)itemId withEntityObject:(NSDictionary *)entityObject;

//update trakcer item with location object (optional)
-(void)trackerUpdateItem:(NSString *)itemId withLocationObject:(NSDictionary *)locationObject;

//add any custom object for trakcer item, only JSON formate support. (optional)
-(void)trackerUpdateItem:(NSString *)itemId withCustomObject:(NSDictionary *)object customObjectKeyName:(NSString *)keyName;

//exit item for record timespan (optional)
-(void)trackerExitItem:(NSString *)itemId;

//send all tracker items
-(void)trackerSendItems;

#pragma mark - Tracker Object Helper

#pragma mark User Object
/**
 engage user for this tracker item.
 @param email      string
 @param phone      string
 @param fbId       string
 @param gender     string for "M" or "F"
 @param birthdat   birthday for yyyy/MM/dd
 @param meta       anything custom meta
 */
+(NSDictionary *)helper_userObjectWithEmail:(NSString *)email
                                     phone:(NSString *)phone
                                      fbId:(NSString *)fbId
                                    gender:(NSString *)gender
                                  birthday:(NSString *)birthday
                             addtionalMeta:(NSDictionary *)meta;


#pragma mark Entity Object
/**
 basic entity object with all-custom fields
 @param type kTKEntityTypePOST, kTKEntityTypePLACE, etc..
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




@end
