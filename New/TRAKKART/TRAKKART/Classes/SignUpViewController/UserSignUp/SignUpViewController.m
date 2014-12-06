//
//  SignUpViewController.m
//  TRAKKART
//
//  Created by Mac Min on 22/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpView.h"
#import "WebserviceCall.h"
#import "WebserviceManager.h"
#import "DriverSignUpViewController.h"
#import "MainScreenViewController.h"
@interface SignUpViewController ()<SignUpViewDelegate>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objSignUpView.delegate=self;
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [objSignUpView startBackgroundAnimation];
}
-(void)viewWillDisappear:(BOOL)animated
{
   [objSignUpView stopBackgroundAnimation];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [objSignUpView resetFrame];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Update SignUpView Data From DriverSignUpView
-(void)updateSignUpDataValueFromDriverSignUp:(NSMutableDictionary *)dicData
{
    [objSignUpView UpdateViewData:dicData];
}
-(void)deSelectDriverCheckBox
{
    [objSignUpView unSelectedDriverCheckbox];
}

#pragma mark - SignUpView Delegate Method Implementation

-(void)moveToRootViewContoller
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)registerDriver:(NSDictionary *)driverData
{
    
    [self pushToDriverSignUpViewController:[driverData mutableCopy]];
}
-(void)registerUser:(NSDictionary *)userData
{
    
    WebserviceCall *webserviceCall = [[WebserviceManager sharedInstance] getWebserviceCallObjectWithDelegate:self withResponseType:WebserviceCallResponseJSON cachePolicy:WebserviceCallCachePolicyRequestFromUrlNoCache];
    webserviceCall.postDataDict = userData;
    [webserviceCall setIsShowLoader:YES];
    [[WebserviceManager sharedInstance] callWebserviceForSignUpWithSuccessSelectorNotification:@selector(callBackOnSignUpWithSuccessNotification:) failureSelectorNotification:@selector(callBackOnSignUpWithFailureNotification:) webserviceCall:webserviceCall];
}

-(void)callBackOnSignUpWithSuccessNotification:(NSNotification *)notification
{
    WebserviceResponse *wsResponse = [notification object];
    NSDictionary *data;
    
    if([wsResponse.webserviceResponse isKindOfClass:[NSDictionary class]])
    {
        data = (NSDictionary *)wsResponse.webserviceResponse;
        if([[data objectForKey:WebserviceErrorKey] isEqualToNumber:[NSNumber numberWithBool:1]])
        {
            [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:[data objectForKey:WebserviceMessageKey] delegate:self];
        }
        else
        {
                UIStoryboard *storyboard = nil;
                
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainScreenViewController *objMainScreenViewController=[storyboard instantiateViewControllerWithIdentifier:@"MainScreenViewControllerIdentifier"];
                
                
                [self.navigationController pushViewController:objMainScreenViewController animated:YES];
              
        }
    }
}

-(void)callBackOnSignUpWithFailureNotification:(NSNotification *)notification
{
    [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"No Response" delegate:self];
}

#pragma mark - Push To ViewContoller
-(void)pushToDriverSignUpViewController:(NSMutableDictionary  *)dicData
{
    
    UIStoryboard *storyboard = nil;
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DriverSignUpViewController *objDriverSignUpViewController=[storyboard instantiateViewControllerWithIdentifier:@"DriverSignUpViewControllerIdenntifer"];
    objDriverSignUpViewController.dicSignUpData=dicData;
    [self pushToViewController:objDriverSignUpViewController];
    
}

-(void)pushToViewController:(id)viewController
{
    if(!viewController)
        return;
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}



@end
