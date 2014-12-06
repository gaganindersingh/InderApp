//
//  StartUpView.m
//  TRAKKART
//
//  Created by Mac Min on 25/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "StartUpView.h"
#import "MovingImages.h"
@implementation StartUpView

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
    NSArray *arrNib = [[NSBundle mainBundle]loadNibNamed:@"StartUpView" owner:self options:nil];
    UIView *vwMyDetail = [arrNib lastObject];
    [self addSubview:vwMyDetail];
    
}

#pragma mark - Initlization Methods
-(void)initlizationView
{
    if([APPUtility isScreenGreaterThanIphone5])
    {
        constraintVerticalSpaceOfLogoFromTop.constant=100;
    }
}

#pragma mark - Animation Methods
- (IBAction)btnFacebookAction:(id)sender {
    
    if([_delegate respondsToSelector:@selector(LoginWithFacebookMethod)])
    {
        [_delegate performSelector:@selector(LoginWithFacebookMethod) withObject:nil];
    }
}

- (IBAction)btnEmailLoginAction:(id)sender {
    
    if([_delegate respondsToSelector:@selector(moveToLoginScreen)])
    {
        [_delegate performSelector:@selector(moveToLoginScreen) withObject:nil];
    }
}

- (IBAction)btnLoginAction:(id)sender {
    
   
}

-(void)startBackgroundAnimation
{
    [objMovingImages startAnimation];
}

-(void)stopBackgroundAnimation
{
    [objMovingImages invalidateTimer];
}





@end
