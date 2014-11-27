//
//  StartUpView.h
//  TRAKKART
//
//  Created by Mac Min on 25/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovingImages;
@protocol StartUpViewDelegate <NSObject>

@optional
-(void)moveToLoginScreen;
@end
@interface StartUpView : UIView
{
    
    IBOutlet MovingImages *objMovingImages;
}

@property (nonatomic,assign)id<StartUpViewDelegate> delegate;
- (IBAction)btnFacebookAction:(id)sender;
- (IBAction)btnEmailLoginAction:(id)sender;
- (IBAction)btnLoginAction:(id)sender;

-(void)startBackgroundAnimation;
-(void)stopBackgroundAnimation;
@end
