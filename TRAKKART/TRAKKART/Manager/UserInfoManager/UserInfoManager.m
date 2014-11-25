//
//  UserInfoManager.m
//  VideoTag
//
//  Created by Aditya Aggarwal on 20/03/14.
//
//

#import "UserInfoManager.h"

@implementation UserInfoManager

#pragma mark - Setter

+(void)setUserInfo:(UserInfoModel *)userInfoModel
{
    if(!userInfoModel)
        return;
    
    NSData* archivedServerModules = [NSKeyedArchiver archivedDataWithRootObject:userInfoModel];
    [[NSUserDefaults standardUserDefaults] setObject:archivedServerModules forKey:UserInfoManagerUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Getter

+(UserInfoModel *)getUserInfo
{
    NSData* archivedServerModules = [[NSUserDefaults standardUserDefaults] objectForKey:UserInfoManagerUserKey];
    UserInfoModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:archivedServerModules];
    return userInfoModel;
}

#pragma mark - Remove user's info

+(void)removeUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserInfoManagerUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
