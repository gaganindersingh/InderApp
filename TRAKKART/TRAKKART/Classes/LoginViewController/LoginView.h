//
//  LoginView.h
//  TRAKART
//
//  Created by Mac Min on 21/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovingImages;

@protocol LoginViewDelegate <NSObject>

@optional
-(void)authenticateUser:(NSDictionary *)userInfo;
-(void)retrivePasswordOfUser:(NSString *)email;
-(void)moveToUserRegisterationScreen;
@end
@interface LoginView : UIView<UITextFieldDelegate>
{
    
    __weak IBOutlet MovingImages *objMovingImage;
    
    IBOutlet UITextField *txtFieldUsername;
   
    IBOutlet UITextField *txtFieldPassword;
    
    IBOutlet UIButton *btnLogin;
    
    IBOutlet UIView *txtFieldPwdBg;
    IBOutlet UIView *txtFieldBg;
    
    
    IBOutlet NSLayoutConstraint *constraintVerticalSpaceFromBottomOfSignUpBtn;
    IBOutlet NSLayoutConstraint *constraintVerticalSpaceFromTop_OfUsernameTxtField;
}
@property (nonatomic,assign)id<LoginViewDelegate> delegate;
- (IBAction)btnLoginAction:(id)sender;
- (IBAction)btnForgotPasswordAction:(id)sender;
- (IBAction)btnSignUpAction:(id)sender;
-(void)startBackgroundAnimation;
-(void)stopBackgroundAnimation;



@end
