//
//  ViewController.m
//  TRAKART
//
//  Created by Mac Min on 20/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initlizationBaseView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initlizationBaseView
{
    NSMutableArray
    *arrImages=[[NSMutableArray alloc]init];
    for (int i=1; i<=5; i++) {
        [arrImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg",i]]];
        
    }
    
    
    [imgVwMovingImages setAnimationImages:arrImages];
    [imgVwMovingImages setAnimationDuration:5.0];
    //[imgVwMovingImages startAnimating];
    
   

}
@end
