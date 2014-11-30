//
//  LoginView.m
//  TRAKART
//
//  Created by Mac Min on 21/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "LoginView.h"
#import "MovingImages.h"
#define keyboardAnimationDuration 0.30
@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)awakeFromNib
{
    [self setup];
    [self initlizationView];
}

#pragma mark - Setup 
-(void)setup
{
    NSArray *arrNib = [[NSBundle mainBundle]loadNibNamed:@"LoginView" owner:self options:nil];
    UIView *vwMyDetail = [arrNib lastObject];
    [self addSubview:vwMyDetail];

}

#pragma mark - Initlization Methods
-(void)initlizationView
{
    //[objMovingImage startAnimation];
     UIColor *color = [UIColor whiteColor];
     txtFieldUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldUsername.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    txtFieldPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtFieldPassword.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    if([APPUtility isIphone4])
    {
        constraintVerticalSpaceFromTop_OfUsernameTxtField.constant=180;
        constraintVerticalSpaceFromBottomOfSignUpBtn.constant=50;
    }
    
    if([APPUtility isScreenGreaterThanIphone5]) // Setting For Greater Than Iphone 5
    {
        constraintVerticalSpaceOfLogoFromTop.constant=[KLogoY_AxisFromTop intValue];

    }
    
}

#pragma mark - IBAction Methods

- (IBAction)btnLoginAction:(id)sender {
    
    if(txtFieldUsername.text.length!=0)
    {
        if(txtFieldPassword.text.length!=0)
        {
           if([_delegate respondsToSelector:@selector(authenticateUser:)])
           {
               NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:txtFieldUsername.text,@"username",txtFieldPassword.text,@"password",nil];
               [self resetFrame];
               [self resignKeyboard];
               [_delegate performSelector:@selector(authenticateUser:) withObject:dic];
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

- (IBAction)btnForgotPasswordAction:(id)sender {
    [APPUtility showUnderDevelopmentAlert];
    
    return;
}

- (IBAction)btnSignUpAction:(id)sender {
    
    if([_delegate respondsToSelector:@selector(moveToUserRegisterationScreen)])
    {
        [self resetFrame];
        [self resignKeyboard];
        [_delegate performSelector:@selector(moveToUserRegisterationScreen) withObject:nil];
    }
}

#pragma mark - TextField Delegate Method
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == txtFieldPassword)
        [APPUtility setFrameOfView:self withRect:CGRectMake(self.frame.origin.x, -80, self.frame.size.width, self.frame.size.height) withAnimationDuration:keyboardAnimationDuration];
    
    return YES;
}

-(void)resetFrame
{
    [APPUtility setFrameOfView:self withRect:CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height) withAnimationDuration:keyboardAnimationDuration];
    
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
    [objMovingImage startAnimation];
}

-(void)stopBackgroundAnimation
{
    [objMovingImage invalidateTimer];
}

@end
