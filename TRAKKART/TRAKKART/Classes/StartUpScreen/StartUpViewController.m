//
//  StartUpViewController.m
//  TRAKKART
//
//  Created by Mac Min on 25/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "StartUpViewController.h"
#import "StartUpView.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MainScreenViewController.h"
#import "Loader.h"
@interface StartUpViewController ()<StartUpViewDelegate>
{
    Loader *objLoader;
}
@end

@implementation StartUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [objStartUpView startBackgroundAnimation];
    objStartUpView.delegate=self;
//    FBLoginView *loginView = [[FBLoginView alloc] init];
//    loginView.center = self.view.center;
//    [self.view addSubview:loginView];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController.navigationBar setHidden:YES];
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

- (void)moveToFeedView {
    UIStoryboard *storyboard = nil;
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    id controller=[storyboard instantiateViewControllerWithIdentifier:@"FeedViewControllerIdentifier"];
    
    if(!controller)
        return;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)LoginWithFacebookMethod
{
    if(!objLoader)
    objLoader=[[Loader alloc]init];
    
    [objLoader showLoader];
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
              [self makeRequestForUserData];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             //[self faceBookLogin];
             [self makeRequestForUserData];
             
         }];
    }
}


- (void) makeRequestForUserData
{
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // Success! Include your code to handle the results here
            NSLog(@"user info: %@", result);
            [objLoader hideLoader];
            [self pushToMainDashboardScreen];
        } else {
            // An error occurred, we need to handle the error
            // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
            NSLog(@"error %@", error.description);
        }
    }];
}


-(void)pushToMainDashboardScreen
{
    UIStoryboard *storyboard = nil;
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainScreenViewController *objMainScreenViewController=[storyboard instantiateViewControllerWithIdentifier:@"MainScreenViewControllerIdentifier"];
    AppDelegate *delegate=[[UIApplication sharedApplication]delegate];
    
    if(!objMainScreenViewController)
        return;
    
    //[delegate.window setRootViewController:objMainScreenViewController];
    
     [self.navigationController pushViewController:objMainScreenViewController animated:YES];
}
@end
