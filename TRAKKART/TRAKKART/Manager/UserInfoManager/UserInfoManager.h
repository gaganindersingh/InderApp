//
//  UserInfoManager.h
//  VideoTag
//
//  Created by Aditya Aggarwal on 20/03/14.
//
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

#define UserInfoManagerUserKey @"UserInfoManagerUserKey"

@interface UserInfoManager : NSObject{
    
}

#pragma mark - Setter

+(void)setUserInfo:(UserInfoModel *)userInfoModel;

#pragma mark - Getter

+(UserInfoModel *)getUserInfo;

#pragma mark - Remove user's info

+(void)removeUserInfo;

@end
