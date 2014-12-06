//
//  DriverSignUpView.m
//  TRAKKART
//
//  Created by Mac Min on 26/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "DriverSignUpView.h"
#import "MovingImages.h"
@implementation DriverSignUpView


-(void)awakeFromNib
{
    [self setup];
    [self initilization];
}

-(void)setup
{
    NSArray *arrNib = [[NSBundle mainBundle]loadNibNamed:@"DriverSignUpView" owner:self options:nil];
    UIView *vwMyDetail = [arrNib lastObject];
    [self addSubview:vwMyDetail];
    
    
}
-(void)initilization
{
    UIColor *color = [UIColor whiteColor];
    txtFieldAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldAddress.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    txtFieldPhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldPhoneNumber.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    txtFieldSocialSecurityNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldSocialSecurityNumber.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    UITapGestureRecognizer *detechTouchOnScrollViewGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detechTouchOnScrollViewGestureAction:)];
    detechTouchOnScrollViewGesture.numberOfTouchesRequired=1;
    detechTouchOnScrollViewGesture.numberOfTapsRequired=1;
    [scrollview addGestureRecognizer:detechTouchOnScrollViewGesture];
    
    dicSignUpDriverData=[[NSMutableDictionary alloc]init];
    
    if([APPUtility isScreenGreaterThanIphone5])
    {
        constraintVerticalSpaceOfLogoFromTop.constant=25;
    }
}
- (IBAction)btnSignUp:(id)sender {
    
    if(txtFieldAddress.text.length!=0)
    {
        if(txtFieldPhoneNumber.text.length!=0)
        {
            if(txtFieldSocialSecurityNumber.text.length!=0)
            {
                [self fillDriverViewData];
                if([_delegate respondsToSelector:@selector(signUpDriver:)])
                {
                    [_delegate performSelector:@selector(signUpDriver:) withObject:dicSignUpDriverData];
                }
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

- (IBAction)btnBackClicked:(id)sender {
    
    
    if([_delegate respondsToSelector:@selector(backButtonAction)])
    {
        [self fillDriverViewData];
        [_delegate performSelector:@selector(backButtonAction) withObject:dicSignUpDriverData];
    }
}

#pragma mark - Fill DriverView Data In Dictionary
-(void)fillDriverViewData
{
   
    [dicSignUpDriverData setObject:txtFieldAddress.text forKey:@"driverAddressname"];
    [dicSignUpDriverData setObject:txtFieldPhoneNumber.text forKey:@"driverPhoneNumber"];
    [dicSignUpDriverData setObject:txtFieldSocialSecurityNumber.text forKey:@"driverSocialSecurityNumber"];
    [dicSignUpDriverData setObject:@"driver" forKey:@"userType"];
}

#pragma mark - DetechTouchOnScrollViewGesture Handler
-(void)detechTouchOnScrollViewGestureAction:(UITapGestureRecognizer *)sender
{
    [self resetFrame];
    [self endEditing:YES];
}


#pragma mark - Update view data
-(void)updateSignUpdate:(NSMutableDictionary *)data
{
    dicSignUpDriverData=data;
    
    txtFieldAddress.text=[APPUtility getObjectForKey:@"driverAddressname" fromDict:data];
    txtFieldPhoneNumber.text=[APPUtility getObjectForKey:@"driverPhoneNumber" fromDict:data];
    txtFieldSocialSecurityNumber.text=[APPUtility getObjectForKey:@"driverSocialSecurityNumber" fromDict:data];

}

#pragma mark - Send Data To User SignUp View
-(NSMutableDictionary *)SendDataToSignUpView
{
    return dicSignUpDriverData;
}

#pragma mark - Animation Methods
-(void)startBackgroundAnimation
{
    [objMovingImages startAnimation];
}

-(void)stopBackgroundAnimation
{
    [objMovingImages invalidateTimer];
}


#pragma mark - TextField Delegate Method
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat y_axis;
    
    if (textField == txtFieldAddress)
    {
        y_axis=70;
    }
    else if (textField==txtFieldPhoneNumber)
    {
        y_axis=70;
    }
    else if (textField==txtFieldSocialSecurityNumber)
    {
        y_axis=240;
    }
    
    scrollview.scrollEnabled=false;
    [scrollview setContentOffset:CGPointMake(0,y_axis ) animated:YES];
    return YES;
}

-(void)resetFrame
{
    scrollview.scrollEnabled=TRUE;
    [scrollview setContentOffset:CGPointMake(0,0) animated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resetFrame];
    [textField resignFirstResponder];
    return TRUE;
}

@end
