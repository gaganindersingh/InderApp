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

}

#pragma mark - Sign Up Action
- (IBAction)btnCheckBoxAction:(id)sender {
    [APPUtility showUnderDevelopmentAlert];
}

- (IBAction)btnSignUpAction:(id)sender {
//        [APPUtility showUnderDevelopmentAlert];
//    return;
    
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
                                /*
                                //http://gagan.byethost11.com/trakart/webservices/index.php?service=register
                                {
                                    "username":"myusername",
                                    "name":"myname",
                                    "email":"myemail",
                                    "address":"myaddress",
                                    "age":25,
                                    "password":"mypassword"
                                }
                                 */
                                
                            // For Driver
                                /*
                                 NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:txtFieldUserName.text,@"username",txtFieldName
                                 .text,@"name",txtFieldEmail.text,@"email",txtFieldDeliveryAddress.text,@"address",txtFieldAge.text,@"age",txtFieldPassword.text,@"password", nil];
                                 */
                                
                                 NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:txtFieldUserName.text,@"username",txtFieldName
                                .text,@"name",txtFieldEmail.text,@"email",txtFieldDeliveryAddress.text,@"address",txtFieldAge.text,@"age",txtFieldPassword.text,@"password", nil];
                                
                                if([_delegate respondsToSelector:@selector(registerUser:)])
                                {
                                    [_delegate performSelector:@selector(registerUser:) withObject:dic];
                                }
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
}

- (IBAction)btnLoginAction:(id)sender {
    
    if([_delegate respondsToSelector:@selector(moveToRootViewContoller)])
    {
        [_delegate performSelector:@selector(moveToRootViewContoller) withObject:nil];
    }
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
