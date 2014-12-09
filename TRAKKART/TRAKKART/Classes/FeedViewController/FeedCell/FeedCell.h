//
//  FeedCell.h
//  TRAKKART
//
//  Created by Varun on 8/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UICollectionViewCell {
    
    __weak IBOutlet UILabel *lblTitleForCell;
    __weak IBOutlet UITableView *tableViewInCell;
}

- (void)fillFeedCellValuesForIndex:(NSInteger)indexValue
                         withTitle:(NSString *)title;

@end
