//
//  SignUp.h
//  TRAKKART
//
//  Created by Mac Min on 29/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignUp : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *userType;
@property (nonatomic,strong) NSString *deliveryAddress;
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,strong) NSString *socialSecurityNumber;

-(void)fillData:(NSDictionary *)dicData;
@end
