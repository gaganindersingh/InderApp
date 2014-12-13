//
//  FeedView.m
//  TRAKKART
//
//  Created by Varun on 7/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "FeedView.h"
#import "FeedCell.h"
#import "BadgeView.h"

static NSString *REUSEID_CVFC = @"cvFeedCell";

@interface FeedView () <UICollectionViewDelegate> {
    NSMutableArray *arrFeedTypes;
    NSInteger selectedType;
}

@end

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

-(void)setup {
    
    arrFeedTypes = [[NSMutableArray alloc] initWithObjects:
                    @"Requests", @"List Updates", @"Delivery Updates",
                    @"Coupons", @"Delivery Requests", nil];
    selectedType = 1;
    
    NSArray *arrNib = [[NSBundle mainBundle]loadNibNamed:@"FeedView" owner:self options:nil];
    UIView *vwMyDetail = [arrNib lastObject];
    [self addSubview:vwMyDetail];
    
    [self setupScrollView];
}

- (void)setupScrollView {
    
    CGFloat xOffset = 0;
    
    for (int i = 0; i < [arrFeedTypes count]; i ++) {
        
        NSString *strItemText = [arrFeedTypes objectAtIndex:i];
        CGSize sizeText = [APPUtility getSizeOfText:strItemText
                                           forWidth:200
                                           withFont:[UIFont systemFontOfSize:16]];
        CGRect frameBadgeView = CGRectMake(xOffset, 0, sizeText.width + 60, 40);
        
        BadgeView *objBadgeView = [[BadgeView alloc] initWithFrame:frameBadgeView
                                                             title:strItemText
                                                        badgeValue:i * 45];
        [objBadgeView setTag:i + 1];
        [objBadgeView setSelected:!i];
        
        UITapGestureRecognizer *tapOnTypeView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnTypeView:)];
        [tapOnTypeView setNumberOfTapsRequired:1];
        [objBadgeView addGestureRecognizer:tapOnTypeView];
        
        [scrollViewHeader addSubview:objBadgeView];
        
        xOffset = CGRectGetMaxX(frameBadgeView) + 1;
    }
    [scrollViewHeader setContentSize:CGSizeMake(xOffset, 40)];
}

#pragma mark - Initlization Methods
-(void)initlizeView
{
    UINib *collCellNib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [collectionViewFeeds registerNib:collCellNib forCellWithReuseIdentifier:REUSEID_CVFC];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize cellSize = CGSizeMake(screenSize.width, screenSize.height - 104);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:cellSize];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [collectionViewFeeds setCollectionViewLayout:flowLayout];
}

#pragma mark - Tap on Badge View

- (void)tappedOnTypeView:(UITapGestureRecognizer *)recognizer {

    if ([[recognizer view] tag] != selectedType) {
        
        BadgeView *tappedView = (BadgeView *)[recognizer view];
        [tappedView setSelected:YES];
        
        BadgeView *lastSelectedView = (BadgeView *)[scrollViewHeader viewWithTag:selectedType];
        [lastSelectedView setSelected:NO];
        
        selectedType = [tappedView tag];
        
        CGSize collSize = collectionViewFeeds.frame.size;
        [collectionViewFeeds setContentOffset:CGPointMake(collSize.width * (selectedType - 1), 0)
                                     animated:YES];
    }
}

#pragma mark - UICollectionView Delegate & DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    NSMutableArray *arrSection = [arrSpotsData objectAtIndex:section];
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedCell *objFeedCell = (FeedCell *)[collectionViewFeeds dequeueReusableCellWithReuseIdentifier:REUSEID_CVFC forIndexPath:indexPath];
    [objFeedCell fillFeedCellValuesForIndex:indexPath.row
                                  withTitle:[arrFeedTypes objectAtIndex:indexPath.row]
                           withSelectedType:selectedType];
    [objFeedCell setSelectedBackgroundView:nil];
    return objFeedCell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    DLog(@"Index Row : %ld", indexPath.row);
//    Spot *objSpot = (Spot *)[arrSpotsData objectAtIndex:indexPath.row];
//    if ([_delegate respondsToSelector:@selector(openSpotViewControllerWithSpot:)])
//        [_delegate openSpotViewControllerWithSpot:objSpot];
}

@end
