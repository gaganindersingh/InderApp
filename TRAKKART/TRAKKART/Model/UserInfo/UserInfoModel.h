//
//  UserInfoModel.h
//  VideoTag
//
//  Created by Aditya Aggarwal on 20/03/14.
//
//


#import <Foundation/Foundation.h>

#define userIdKey @"userId"
#define userTypeKey @"userType"
#define userSubscriptionStatusKey @"userSubscriptionStatus"
#define userEmailIdKey @"userEmailId"
#define userFirstNameKey @"userFirstName"
#define userLastNameKey @"userLastName"
#define userNameKey @"username"
#define userAddressKey @"userAddress"
#define userTownKey @"userTown"
#define userStatusKey @"userStatus"
#define userPostCodeKey @"userPostCode"
#define userCountryKey @"userCountry"
#define userTelephoneKey @"userTelephone"
#define userSelfAssignKey @"selfAssign"

@interface UserInfoModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *userSubscriptionStatus;
@property (nonatomic, strong) NSString *userEmailId;
@property (nonatomic, strong) NSString *userFirstName;
@property (nonatomic, strong) NSString *userLastName;
@property (nonatomic, strong) NSString *userLoginName;
@property (nonatomic, strong) NSString *userAddress;
@property (nonatomic, strong) NSString *userTown;
@property (nonatomic, strong) NSString *userPostCode;
@property (nonatomic, strong) NSString *userCountry;
@property (nonatomic, strong) NSString *userTelephone;
@property (nonatomic, strong) NSString *userSelfAssign;

-(NSString *)getUserName;

@end
