//
//  SignUp.m
//  TRAKKART
//
//  Created by Mac Min on 29/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "SignUp.h"

@implementation SignUp

-(void)fillData:(NSDictionary *)dicData
{
    if(!dicData)
        return;
    
    _name=[APPUtility getObjectForKey:@"" fromDict:dicData];
    _userName=[APPUtility getObjectForKey:@"" fromDict:dicData];
    _userType=[APPUtility getObjectForKey:@"" fromDict:dicData];
    _address=[APPUtility getObjectForKey:@"" fromDict:dicData];
    _deliveryAddress=[APPUtility getObjectForKey:@"" fromDict:dicData];
    _password=[APPUtility getObjectForKey:@"" fromDict:dicData];
    _age=[APPUtility getObjectForKey:@"" fromDict:dicData];
    _phoneNumber=[APPUtility getObjectForKey:@"" fromDict:dicData];
    _socialSecurityNumber=[APPUtility getObjectForKey:@"" fromDict:dicData];
}
@end
