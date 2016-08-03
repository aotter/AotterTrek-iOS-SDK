


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

-(void)ATUserInitialWithDeviceId:(NSString*)deviceId
                           email:(NSString *)email
                           phone:(NSString *)phone
                            fbId:(NSString *)fbId
                          gender:(BOOL)isMale
                        birthday:(NSDateComponents *)birthday;


-(void)ATUserUpdateValue:(id)value
                  forKey:(ATUserKey)ATUserKey;

-(void)ATUserRemoveUser;



@end
