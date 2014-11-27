//
//  DriverSignUpView.m
//  TRAKKART
//
//  Created by Mac Min on 26/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "DriverSignUpView.h"

@implementation DriverSignUpView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnSignUp:(id)sender {
    
    if(txtFieldAddress.text.length!=0)
    {
        if(txtFieldPhoneNumber.text.length!=0)
        {
            if(txtFieldSocialSecurityNumber.text.length!=0)
            {
                
            }
            else
            {
                 [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter your social security Number" delegate:self];
            }
        }
        else
        {
             [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter your phone number" delegate:self];
        }
    }
    else
    {
       [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter you address" delegate:self];
    }
}



@end
