//
//  SignUpView.m
//  TRAKKART
//
//  Created by Mac Min on 22/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "SignUpView.h"
#import "MovingImages.h"
@implementation SignUpView

-(void)awakeFromNib
{
    [self setup];
    [self initlizationView];

}
#pragma mark - Setup
-(void)setup
{
    NSArray *arrNib = [[NSBundle mainBundle]loadNibNamed:@"SignUpView" owner:self options:nil];
    UIView *vwMyDetail = [arrNib lastObject];
    [self addSubview:vwMyDetail];
    
    
}

#pragma mark - Intilization

-(void)initlizationView
{
    vwAlltxtFieldsBg.layer.cornerRadius=5.0;
    vwCircle.layer.cornerRadius=vwCircle.frame.size.width/2;
    
    UIColor *color = [UIColor whiteColor];
    txtFieldAge.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldAge.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    txtFieldEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldEmail.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    txtFieldPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldPassword.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    txtFieldUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldUserName.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    txtFieldName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldName.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    txtFieldDeliveryAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldDeliveryAddress.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    btnCheckBox.layer.borderWidth=0.5;
    btnCheckBox.layer.borderColor=[UIColor darkGrayColor].CGColor;
    
    UITapGestureRecognizer *detechTouchOnScrollViewGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detechTouchOnScrollViewGestureAction:)];
    detechTouchOnScrollViewGesture.numberOfTouchesRequired=1;
    detechTouchOnScrollViewGesture.numberOfTapsRequired=1;
    [scrollView addGestureRecognizer:detechTouchOnScrollViewGesture];
   
    if([APPUtility isScreenGreaterThanIphone5])
    {
        constraintVerticalSpaceOfLogoFromTop.constant=20;
        constraintVerticalSpaecOfDateDetailViewFromLogo.constant=20;
        constraintVerticalSpaceOfSignUpButtonFromDataDetailView.constant=15;
        constraintVeticalSpaceOfLoginButtonFromSignUpBtn.constant=15;
    }

}


#pragma mark - DetechTouchOnScrollViewGesture Handler
-(void)detechTouchOnScrollViewGestureAction:(UITapGestureRecognizer *)sender
{
    [self resetFrame];
    [self endEditing:YES];
}


#pragma mark -Sign Dictionary
-(NSMutableDictionary *)dicSignUpData
{
    if(!dicSignUpData)
        dicSignUpData=[[NSMutableDictionary alloc]init];
    
    return dicSignUpData;
}
#pragma mark - UpdateView Data
-(void)UpdateViewData:(NSMutableDictionary *)dic
{
    dicSignUpData=dic;
    txtFieldName.text=[APPUtility getObjectForKey:@"name" fromDict:dic];
    txtFieldUserName.text=[APPUtility getObjectForKey:@"username" fromDict:dic];
    txtFieldPassword.text=[APPUtility getObjectForKey:@"password" fromDict:dic];
    txtFieldEmail.text=[APPUtility getObjectForKey:@"email" fromDict:dic];
    txtFieldAge.text=[APPUtility getObjectForKey:@"age" fromDict:dic];
    txtFieldDeliveryAddress.text=[APPUtility getObjectForKey:@"address" fromDict:dic];
    
}

#pragma mark - Fill View SignUp Data
-(BOOL)fillViewSignUpData
{
    BOOL isError=TRUE;
    
    if(txtFieldName.text.length!=0)
    {
        if(txtFieldEmail.text.length!=0)
        {
            if([APPUtility validateEmail:txtFieldEmail.text])
            {
                if(txtFieldUserName.text.length!=0)
                {
                    if(txtFieldPassword.text.length!=0)
                    {
                        if(txtFieldDeliveryAddress.text.length!=0)
                        {
                            if(txtFieldAge.text.length!=0)
                            {
                                isError=false;
                            }
                            else
                            {
                                [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter your age" delegate:self];
                            }
                        }
                        else
                        {
                            [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter delivery address" delegate:self];
                        }
                    }
                    else
                    {
                        [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter password" delegate:self];
                    }
                }
                else
                {
                    [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter username" delegate:self];
                }
                
            }
            else
            {
                [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter correct email" delegate:self];
            }
        }
        else
        {
            [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter your email" delegate:self];
        }
        
    }
    else
    {
        [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Please enter your name" delegate:self];
    }
    
    
    if(!isError)
    {
        [[self dicSignUpData] setObject:txtFieldUserName.text forKey:@"username"];
        [[self dicSignUpData] setObject:txtFieldEmail.text forKey:@"email"];
        [[self dicSignUpData] setObject:txtFieldName.text forKey:@"name"];
        [[self dicSignUpData] setObject:txtFieldDeliveryAddress.text forKey:@"address"];
        [[self dicSignUpData] setObject:txtFieldAge.text forKey:@"age"];
        [[self dicSignUpData] setObject:txtFieldPassword.text forKey:@"password"];
        [[self dicSignUpData] setObject:@"user"forKey:@"userType"];
        [[self dicSignUpData] setObject:@""forKey:@"driverAddressname"];
        [[self dicSignUpData] setObject:@""forKey:@"driverPhoneNumber"];
        [[self dicSignUpData] setObject:@""forKey:@"driverSocialSecurityNumber"];
        

    }
    
    return isError;
    
}

#pragma mark - IBAction Methods
- (IBAction)btnSignUpAction:(id)sender {

    BOOL isError=  [self fillViewSignUpData];
    
    if(isError)
        return;
    
    
    if([_delegate respondsToSelector:@selector(registerUser:)])
    {
        [_delegate performSelector:@selector(registerUser:) withObject:dicSignUpData];
    }
}

- (IBAction)btnLoginAction:(id)sender {
    
    if([_delegate respondsToSelector:@selector(moveToRootViewContoller)])
    {
        [_delegate performSelector:@selector(moveToRootViewContoller) withObject:nil];
    }
}

- (IBAction)btnCheckBoxAction:(id)sender {
    
   BOOL isError= [self fillViewSignUpData];
    
    if(isError)
        return;
    
    if(!isDriver)
    {
        
        if([_delegate respondsToSelector:@selector(registerDriver:)])
        {
            isDriver=TRUE;
            [btnCheckBox setImage:[UIImage imageNamed:@"Checked_icon.png"] forState:UIControlStateNormal];
            [_delegate performSelector:@selector(registerDriver:) withObject:dicSignUpData];
        }
    }
    else
    {
        [self unSelectedDriverCheckbox];
    }

}

#pragma mark - UnSelect Driver Checkbox
-(void)unSelectedDriverCheckbox
{
    isDriver=false;
    [btnCheckBox setImage:nil forState:UIControlStateNormal];
    
}
#pragma mark - TextField Delegate Method
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat y_axis;
    
    if (textField == txtFieldEmail)
    {
        y_axis=70;
    }
    else if (textField==txtFieldUserName)
    {
        y_axis=110;
    }
    else if (textField==txtFieldPassword)
    {
             y_axis=150;
    }
    else if (textField==txtFieldDeliveryAddress)
    {
             y_axis=190;
    }
    else if (textField==txtFieldAge)
    {
             y_axis=230;
    }
    scrollView.scrollEnabled=false;
    [scrollView setContentOffset:CGPointMake(0,y_axis ) animated:YES];
    return YES;
}

-(void)resetFrame
{
    scrollView.scrollEnabled=TRUE;
    [scrollView setContentOffset:CGPointMake(0,0) animated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resetFrame];
    [textField resignFirstResponder];
    return TRUE;
}

-(void)resignKeyboard
{
    [self endEditing:YES];
}

#pragma mark - UITouch delegate
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resetFrame];
    [self resignKeyboard];
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
@end
