//
//  Loader.m
//  VideoTag
//
//  Created by Amit Saini on 16/04/14.
//
//

#import "Loader.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation Loader

- (void)showLoader
{
    if(loaderView)
    {
        [loaderView setHidden:NO];
        return;
    }
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    loaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [loaderView setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5]];
    loaderView.layer.cornerRadius = 7.0;
    [loaderView setCenter:window.center];//.rootViewController.view.center
    
//    IndicatorView
    UIActivityIndicatorView *indicatorView = [self getActivityIndicator];
    [loaderView addSubview:indicatorView];
    [APPUtility addBasicConstraintsOnSubView:indicatorView onSuperView:loaderView];
    [window addSubview:loaderView];
   
}

- (void)hideLoader
{
    [loaderView setHidden:YES];
}

-(UIActivityIndicatorView *)getActivityIndicator
{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicatorView startAnimating];
    return indicatorView;
}

- (void)dealloc
{
    
}

@end
