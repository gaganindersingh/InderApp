//
//  MainScreenView.h
//  TRAKKART
//
//  Created by Mac Min on 06/12/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovingImages;

@interface MainScreenView : UIView
{
    
    IBOutlet UIView *objMovingImages;
}

-(void)startBackgroundAnimation;
-(void)stopBackgroundAnimation;

@end
