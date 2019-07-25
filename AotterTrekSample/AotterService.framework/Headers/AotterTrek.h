


//AotterTrek

#import <Foundation/Foundation.h>
#import "EnumHeaders.h"

typedef enum {
    ATUserKeyDeviceID,
    ATUserKeyEmail,
    ATUserKeyPhone,
    ATUserKeyFbId,
    ATUserKeyGender,
    ATUserKeyBirthday
}ATUserKey;

#define kAdTypeNative       @"NATIVE"
#define kAdTypeVideo        @"NATIVE_VIDEO"
#define kAdTypeInteractive  @"NATIVE_INTERACTIVE"

@interface AotterTrek : NSObject
@property NSString *clientId;
@property NSString *clientSecret;
@property NSDictionary *currentUser;
@property ATLoggerLevel loggerLevel;

+(AotterTrek *)sharedAPI;

-(void)initServiceWithClientId:(NSString *)clientId
                        secret:(NSString *)clientSecret;

-(void)enableLoggerWithLevel:(ATLoggerLevel)level;

-(BOOL)checkInitSuccess;

#pragma mark - Client user
/**
 user data
 @param email string
 @param phone string
 @param fbId string
 @param gender string for "M" or "F"
 @param birthdat DateComponets for birthday
 @param meta anything custom meta
 */
-(void)ATUserInitialWithEmail:(NSString *)email
                        phone:(NSString *)phone
                         fbId:(NSString *)fbId
                       gender:(NSString *)gender
                     birthday:(NSDateComponents *)birthday
                addtionalMeta:(NSDictionary *)additonalMeta;



-(void)ATUserUpdateValue:(id)value
                  forKey:(ATUserKey)ATUserKey;
-(void)ATUserRemoveUser;



-(void)ATUserInitialWithDeviceId:(NSString*)deviceId
                           email:(NSString *)email
                           phone:(NSString *)phone
                            fbId:(NSString *)fbId
                          gender:(BOOL)isMale
                        birthday:(NSDateComponents *)birthday __attribute__((deprecated));



@end
