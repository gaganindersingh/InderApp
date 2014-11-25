//
//  MovingImages.h
//  TRAKART
//
//  Created by Mac Min on 21/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovingImages : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *vwCollectionView;
    
    NSMutableArray *arrAminationImages;
    
    int scrollIndex;
}

@property (nonatomic, assign) CGPoint scrollingPoint, endPoint;
@property (nonatomic, strong) NSTimer *scrollingTimer;
//+ (id)sharedManager;
//-(void)setMovingImage:(NSMutableArray *)arrImages;
-(void)reloadCollectionView;
-(void)startAnimation;
-(void)invalidateTimer;

@end
