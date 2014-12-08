//
//  FeedView.m
//  TRAKKART
//
//  Created by Varun on 7/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "FeedView.h"
#import "FeedCell.h"

static NSString *REUSEID_CVFC = @"cvFeedCell";

@implementation FeedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [self setup];
    [self initlizeView];
}

#pragma mark - Setup
-(void)setup
{
    NSArray *arrNib = [[NSBundle mainBundle]loadNibNamed:@"FeedView" owner:self options:nil];
    UIView *vwMyDetail = [arrNib lastObject];
    [self addSubview:vwMyDetail];
    
}

#pragma mark - Initlization Methods
-(void)initlizeView
{
    UINib *collCellNib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [collectionViewFeeds registerNib:collCellNib forCellWithReuseIdentifier:REUSEID_CVFC];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize cellSize = CGSizeMake(screenSize.width, screenSize.height - 40);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:cellSize];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [collectionViewFeeds setCollectionViewLayout:flowLayout];
}

#pragma mark - UICollectionView Delegate & DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    NSMutableArray *arrSection = [arrSpotsData objectAtIndex:section];
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedCell *objFeedCell = (FeedCell *)[collectionViewFeeds dequeueReusableCellWithReuseIdentifier:REUSEID_CVFC forIndexPath:indexPath];
    
//    Spot *objSpot = [arrSpotsData objectAtIndex:indexPath.row];
//    CollectionCellSpot *cell = (CollectionCellSpot *)[collectionView dequeueReusableCellWithReuseIdentifier:REUSEID_CV forIndexPath:indexPath];
//    [cell fillCellWithCellText:objSpot];
    [objFeedCell fillFeedCellValuesForIndex:indexPath.row];
    return objFeedCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    DLog(@"Index Row : %ld", indexPath.row);
//    Spot *objSpot = (Spot *)[arrSpotsData objectAtIndex:indexPath.row];
//    if ([_delegate respondsToSelector:@selector(openSpotViewControllerWithSpot:)])
//        [_delegate openSpotViewControllerWithSpot:objSpot];
}

@end
