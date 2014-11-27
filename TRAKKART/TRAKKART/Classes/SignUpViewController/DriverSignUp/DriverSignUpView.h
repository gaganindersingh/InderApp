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
@end
@interface DriverSignUpView : UIView
{
    
    IBOutlet MovingImages *objMovingImages;
    
    IBOutlet UITextField *txtFieldPhoneNumber;
    IBOutlet UITextField *txtFieldAddress;
    
    IBOutlet UITextField *txtFieldSocialSecurityNumber;
}
@property (nonatomic,assign)id<DriverSignUpViewDelegate> delegate;
-(void)updateSignUpdate:(NSMutableDictionary *)data;
- (IBAction)btnSignUp:(id)sender;
-(void)startBackgroundAnimation;
-(void)stopBackgroundAnimation;
@end
