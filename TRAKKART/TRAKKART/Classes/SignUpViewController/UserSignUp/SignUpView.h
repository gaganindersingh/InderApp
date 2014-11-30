//
//  SignUpView.h
//  TRAKKART
//
//  Created by Mac Min on 22/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovingImages;
@protocol  SignUpViewDelegate<NSObject>

@optional
-(void)moveToRootViewContoller;
-(void)registerUser:(NSDictionary *)userData;
-(void)registerDriver:(NSDictionary *)driverData;
@end
@interface SignUpView : UIView
{
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet MovingImages *objMovingImages;
    IBOutlet UIView *vwCircle;
    IBOutlet UIView *vwAlltxtFieldsBg;
    
    IBOutlet UITextField *txtFieldEmail;
    IBOutlet UITextField *txtFieldName;
    
    IBOutlet UITextField *txtFieldAge;
    IBOutlet UITextField *txtFieldDeliveryAddress;
    IBOutlet UITextField *txtFieldPassword;
    IBOutlet UITextField *txtFieldUserName;
    
    IBOutlet UIButton *btnCheckBox;
    NSMutableDictionary *dicSignUpData;
    BOOL isDriver;
    
    IBOutlet NSLayoutConstraint *constraintVerticalSpaceOfLogoFromTop;
    
    IBOutlet NSLayoutConstraint *constraintVerticalSpaecOfDateDetailViewFromLogo;
    
    IBOutlet NSLayoutConstraint *constraintVerticalSpaceOfSignUpButtonFromDataDetailView;
    
    IBOutlet NSLayoutConstraint *constraintVeticalSpaceOfLoginButtonFromSignUpBtn;
    
}

@property (nonatomic,assign)id<SignUpViewDelegate> delegate;
- (IBAction)btnCheckBoxAction:(id)sender;
- (IBAction)btnSignUpAction:(id)sender;
- (IBAction)btnLoginAction:(id)sender;

-(void)unSelectedDriverCheckbox;
-(void)resetFrame;
-(void)UpdateViewData:(NSMutableDictionary *)dic;
-(void)startBackgroundAnimation;
-(void)stopBackgroundAnimation;
@end
