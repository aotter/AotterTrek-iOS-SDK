



#import <Foundation/Foundation.h>
#import "TKEnumHeaders.h"

typedef enum {
    TKUserKeyEmail,
    TKUserKeyPhone,
    TKUserKeyFbId,
    TKUserKeyGender,
    TKUserKeyBirthday
}TKUserKey;


@interface AotterTrek : NSObject
@property NSString *clientId;
@property NSString *clientSecret;
@property NSDictionary *currentUser;
@property TKLoggerLevel loggerLevel;

+(AotterTrek *)sharedAPI;

/**
 * Initialize Trek Service with your app client id and client secret
 * @param clientId      app client id
 * @param clientSecret  app client secret
 */
-(void)initTrekServiceWithClientId:(NSString *)clientId
                        secret:(NSString *)clientSecret;

/**
 * Enable Trek log with specific level.
 * @param level   TKLoggerLevelNone, TKLoggerLevelNormal, TKLoggerLevelDetail
 */
-(void)enableLoggerWithLevel:(TKLoggerLevel)level;


/**
 * Check if Trek service is initialized successfully or not.
 * @return is successed.
 */
-(BOOL)checkTrekServiceIsInitSuccess;



#pragma mark - Client user
/**
 Set your app's current user data
 @param email      string
 @param phone      string
 @param fbId       string
 @param gender     string for "M" or "F"
 @param birthdat   birthday for format yyyy/MM/dd
 @param meta       customized meta data
 */
-(void)setCurrentUserWithEmail:(NSString *)email
                        phone:(NSString *)phone
                         fbId:(NSString *)fbId
                       gender:(NSString *)gender
                     birthday:(NSString *)birthday
                addtionalMeta:(NSDictionary *)additonalMeta;



-(void)updateCurrentUserWithValue:(id)value
                  forKey:(TKUserKey)TKUserKey;


-(void)removeCurrentUser;

@end
