//
//  MainScreenViewController.m
//  TRAKKART
//
//  Created by Mac Min on 30/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

-(void)viewWillLayoutSubviews
{
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Method
-(void)setup
{
    self.navigationItem.title=@"Main Screen";
    [self.navigationItem setHidesBackButton:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self.navigationController.navigationBar setHidden:NO];
    
    UIBarButtonItem *logoutButton=[[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction)];
    [self.navigationItem setLeftBarButtonItem:logoutButton];


}


#pragma mark - Logout Action
-(void)logoutAction
{
    UIStoryboard *storyboard = nil;
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id viewController=[storyboard instantiateViewControllerWithIdentifier:@"NavigationContollerIdentifer"];
    
    AppDelegate *delegate=[[UIApplication sharedApplication]delegate];
    [delegate.window setRootViewController:viewController];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
