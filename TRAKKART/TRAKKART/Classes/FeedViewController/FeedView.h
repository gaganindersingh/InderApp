//
//  FeedView.h
//  TRAKKART
//
//  Created by Varun on 7/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedView : UIView {
    
    __weak IBOutlet UIScrollView *scrollViewHeader;
    __weak IBOutlet UICollectionView *collectionViewFeeds;
}

@end
