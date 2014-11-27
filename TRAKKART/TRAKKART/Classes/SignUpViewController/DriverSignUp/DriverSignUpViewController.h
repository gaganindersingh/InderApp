//
//  DriverSignUpViewController.h
//  TRAKKART
//
//  Created by Mac Min on 26/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "BaseViewController.h"
@class DriverSignUpView;
@interface DriverSignUpViewController : BaseViewController
{
    
    IBOutlet DriverSignUpView *objDriverSignUpView;
}

@property (nonatomic,strong)NSMutableDictionary *dicSignUpData;
@end
