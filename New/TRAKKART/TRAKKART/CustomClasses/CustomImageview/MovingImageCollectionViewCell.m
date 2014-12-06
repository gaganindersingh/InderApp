//
//  MovingImageCollectionViewCell.m
//  TRAKART
//
//  Created by Mac Min on 21/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "MovingImageCollectionViewCell.h"

@implementation MovingImageCollectionViewCell

- (void)awakeFromNib {
 
  //  [self initlization];
}

-(void)initlization
{

}

#pragma mark - Set Background Image
-(void)setImage:(UIImage*)image
{
    [imgVwBackground setImage:image];
}


@end
