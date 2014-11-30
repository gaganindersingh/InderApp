//
//  DriverSignUpViewController.m
//  TRAKKART
//
//  Created by Mac Min on 26/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "DriverSignUpViewController.h"
#import "DriverSignUpView.h"
#import "WebserviceCall.h"
#import "WebserviceManager.h"
#import "SignUpViewController.h"
#import "MainScreenViewController.h"
@interface DriverSignUpViewController ()<DriverSignUpViewDelegate>

@end

@implementation DriverSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objDriverSignUpView.delegate=self;
    
    [objDriverSignUpView updateSignUpdate:_dicSignUpData];

    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [objDriverSignUpView startBackgroundAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [objDriverSignUpView stopBackgroundAnimation];
}

#pragma mark - Update SignUp View Data
-(void)updateSignUpViewDataFromSelfView
{
   // NSMutableDictionary *dicData=[objDriverSignUpView SendDataToSignUpView];
    
    for (id objViewController in self.navigationController.viewControllers) {
        
        if([objViewController isKindOfClass:[SignUpViewController class]])
        {
            SignUpViewController *objSignUpViewController= (SignUpViewController *)objViewController;
           
                [objSignUpViewController deSelectDriverCheckBox];
                break;
           
           // [objSignUpViewController updateSignUpDataValueFromDriverSignUp:dicData];
           // break;
        }
    }
    
}
#pragma mark - Driver SignUp Delegate

-(void)backButtonAction
{
    [self updateSignUpViewDataFromSelfView];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)signUpDriver:(NSMutableDictionary *)dic
{
    WebserviceCall *webserviceCall = [[WebserviceManager sharedInstance] getWebserviceCallObjectWithDelegate:self withResponseType:WebserviceCallResponseJSON cachePolicy:WebserviceCallCachePolicyRequestFromUrlNoCache];
    webserviceCall.postDataDict = dic;
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
            [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:[data objectForKey:WebserviceResponseKey] delegate:self];
        }
        else
        {
            if([[data objectForKey:WebserviceResponseKey] isKindOfClass:[NSDictionary class]])
            {
                
                
                UIStoryboard *storyboard = nil;
                
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainScreenViewController *objMainScreenViewController=[storyboard instantiateViewControllerWithIdentifier:@"MainScreenViewControllerIdentifier"];
                AppDelegate *delegate=(AppDelegate *)KAppDelegate;
                [delegate.window setRootViewController:objMainScreenViewController];
                
                [self.navigationController popToRootViewControllerAnimated:YES];

               // [self pushToViewController:objMainScreenViewController];
                // Response parser
               // [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"Register successfully" delegate:self];

            }
        }
    }
}

-(void)callBackOnSignUpWithFailureNotification:(NSNotification *)notification
{
    [APPUtility showAlert:NSLocalizedString(@"AppName", @"") withMessage:@"No Response" delegate:self];
}


#pragma mark - delloc Method
-(void)dealloc
{
    _dicSignUpData=nil;
}

@end
