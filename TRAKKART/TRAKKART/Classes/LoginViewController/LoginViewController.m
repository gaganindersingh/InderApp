//
//  LoginViewController.m
//  TRAKART
//
//  Created by Mac Min on 21/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "LoginViewController.h"
#import "MovingImages.h"
#import "LoginView.h"
#import "WebserviceCall.h"
#import "WebserviceManager.h"
@interface LoginViewController ()<LoginViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objLoginView.delegate=self;
 
    self.navigationController.navigationBar.hidden=YES;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [objLoginView startBackgroundAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [objLoginView stopBackgroundAnimation];
}
#pragma mark - LoginView Delegate Implementation
-(void)authenticateUser:(NSDictionary *)userInfo
{
    
    WebserviceCall *webserviceCall = [[WebserviceManager sharedInstance] getWebserviceCallObjectWithDelegate:self withResponseType:WebserviceCallResponseJSON cachePolicy:WebserviceCallCachePolicyRequestFromUrlNoCache];
    webserviceCall.postDataDict = userInfo;
    [webserviceCall setIsShowLoader:YES];
    [[WebserviceManager sharedInstance] callWebserviceForSignInWithSuccessSelectorNotification:@selector(callBackOnSignInWithSuccessNotification:) failureSelectorNotification:@selector(callBackOnSignInWithFailureNotification:) webserviceCall:webserviceCall];
}

-(void)callBackOnSignInWithSuccessNotification:(NSNotification *)notification
{
    WebserviceResponse *wsResponse = [notification object];
    NSDictionary *data;
    
    if([wsResponse.webserviceResponse isKindOfClass:[NSDictionary class]])
    {
        data = (NSDictionary *)wsResponse.webserviceResponse;
        if([[data objectForKey:WebserviceErrorKey] isEqualToNumber:[NSNumber numberWithBool:1]])
        {
            [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:[data objectForKey:WebserviceResponseKey] delegate:self];
        }
        else
        {
            if([[data objectForKey:WebserviceResponseKey] isKindOfClass:[NSDictionary class]])
            {
                // Response parser
                [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Login Successfully" delegate:self];
                
            }
        }
    }
}

-(void)callBackOnSignInWithFailureNotification:(NSNotification *)notification
{
    [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"No Response" delegate:self];
}


-(void)retrivePasswordOfUser:(NSString *)email
{
    
}

-(void)moveToUserRegisterationScreen
{
    UIStoryboard *storyboard = nil;
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id controller=[storyboard instantiateViewControllerWithIdentifier:@"SignUpViewControllerIdenntifer"];
    
    if(!controller)
        return;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
