//
//  MovingImageCollectionViewCell.h
//  TRAKART
//
//  Created by Mac Min on 21/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovingImageCollectionViewCell : UICollectionViewCell
{
    
    __weak IBOutlet UIImageView *imgVwBackground;
}
-(void)setImage:(UIImage*)image;

@end
