//
//  StartUpViewController.m
//  TRAKKART
//
//  Created by Mac Min on 25/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "StartUpViewController.h"
#import "StartUpView.h"
@interface StartUpViewController ()<StartUpViewDelegate>

@end

@implementation StartUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [objStartUpView startBackgroundAnimation];
    objStartUpView.delegate=self;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController.navigationBar setHidden:YES];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [objStartUpView stopBackgroundAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - StartUp Screen delegate

-(void)moveToLoginScreen
{
    UIStoryboard *storyboard = nil;
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    id controller=[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerIdentifier"];
    
    if(!controller)
        return;
    
    [self.navigationController pushViewController:controller animated:YES];
}
@end
