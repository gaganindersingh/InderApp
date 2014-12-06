//
//  WebserviceResponseParser.h
//  VideoTag
//
//  Created by Aditya Aggarwal on 21/04/14.
//
//

#import <Foundation/Foundation.h>
#import "UserInfoManager.h"
@class StudentDashboardModel;

@interface WebserviceResponseParser : NSObject{
    
}
+(void)saveUserInfoModel:(NSDictionary *)dict;

@end
