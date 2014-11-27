//
//  DriverSignUpViewController.m
//  TRAKKART
//
//  Created by Mac Min on 26/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "DriverSignUpViewController.h"
#import "DriverSignUpView.h"

@interface DriverSignUpViewController ()<DriverSignUpViewDelegate>

@end

@implementation DriverSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [objDriverSignUpView startBackgroundAnimation];
    objDriverSignUpView.delegate=self;
    
    [objDriverSignUpView updateSignUpdate:_dicSignUpData];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [objDriverSignUpView stopBackgroundAnimation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dealloc
{
    _dicSignUpData=nil;
}

@end
