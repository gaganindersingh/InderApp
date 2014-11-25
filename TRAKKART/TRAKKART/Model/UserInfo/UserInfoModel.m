//
//  UserInfoModel.m
//  VideoTag
//
//  Created by Aditya Aggarwal on 20/03/14.
//
//

#import "UserInfoModel.h"

@implementation UserInfoModel

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        [self setUserId:[aDecoder decodeObjectForKey:userIdKey]];
        [self setUserType:[aDecoder decodeObjectForKey:userTypeKey]];
        [self setUserSubscriptionStatus:[aDecoder decodeObjectForKey:userSubscriptionStatusKey]];
        [self setUserEmailId:[aDecoder decodeObjectForKey:userEmailIdKey]];
        [self setUserFirstName:[aDecoder decodeObjectForKey:userFirstNameKey]];
        [self setUserLastName:[aDecoder decodeObjectForKey:userLastNameKey]];
        [self setUserLoginName:[aDecoder decodeObjectForKey:userNameKey]];
        [self setUserAddress:[aDecoder decodeObjectForKey:userAddressKey]];
        [self setUserTown:[aDecoder decodeObjectForKey:userTownKey]];
        [self setUserPostCode:[aDecoder decodeObjectForKey:userPostCodeKey]];
        [self setUserCountry:[aDecoder decodeObjectForKey:userCountryKey]];
        [self setUserTelephone:[aDecoder decodeObjectForKey:userTelephoneKey]];
        [self setUserSelfAssign:[aDecoder decodeObjectForKey:userSelfAssignKey]];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userId forKey:userIdKey];
    [aCoder encodeObject:_userType forKey:userTypeKey];
    [aCoder encodeObject:_userSubscriptionStatus forKey:userSubscriptionStatusKey];
    [aCoder encodeObject:_userEmailId forKey:userEmailIdKey];
    [aCoder encodeObject:_userFirstName forKey:userFirstNameKey];
    [aCoder encodeObject:_userLastName forKey:userLastNameKey];
    [aCoder encodeObject:_userLoginName forKey:userNameKey];
    [aCoder encodeObject:_userAddress forKey:userAddressKey];
    [aCoder encodeObject:_userTown forKey:userTownKey];
    [aCoder encodeObject:_userPostCode forKey:userPostCodeKey];
    [aCoder encodeObject:_userCountry forKey:userCountryKey];
    [aCoder encodeObject:_userTelephone forKey:userTelephoneKey];
    [aCoder encodeObject:_userSelfAssign forKey:userSelfAssignKey];
}

-(NSString *)getUserName
{
    NSString *username = @"";
    
    if([APPUtility checkIfStringContainsText:_userFirstName])
        username = [NSString stringWithFormat:@"%@ ",_userFirstName];
    if([APPUtility checkIfStringContainsText:_userLastName])
        username = [NSString stringWithFormat:@"%@%@ ",username,_userLastName];
    
    return username;
}

@end
