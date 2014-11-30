//
//  DriverSignUpView.h
//  TRAKKART
//
//  Created by Mac Min on 26/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovingImages;
@protocol DriverSignUpViewDelegate <NSObject>


@optional
-(void)signUpDriver:(NSMutableDictionary *)dic;
-(void)backButtonAction;

@end
@interface DriverSignUpView : UIView<UITextFieldDelegate>
{
    
    IBOutlet MovingImages *objMovingImages;
    
    IBOutlet UITextField *txtFieldPhoneNumber;
    IBOutlet UITextField *txtFieldAddress;
    IBOutlet UITextField *txtFieldSocialSecurityNumber;
    NSMutableDictionary *dicSignUpDriverData;
    IBOutlet UIScrollView *scrollview;
    
    IBOutlet NSLayoutConstraint *constraintVerticalSpaceOfLogoFromTop;
    
}
@property (nonatomic,assign)id<DriverSignUpViewDelegate> delegate;

- (IBAction)btnSignUp:(id)sender;
- (IBAction)btnBackClicked:(id)sender;


-(void)updateSignUpdate:(NSMutableDictionary *)data;
-(NSMutableDictionary *)SendDataToSignUpView;
-(void)startBackgroundAnimation;
-(void)stopBackgroundAnimation;
@end
