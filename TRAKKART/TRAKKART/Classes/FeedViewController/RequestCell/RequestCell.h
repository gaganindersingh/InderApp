//
//  RequestCell.h
//  TRAKKART
//
//  Created by Varun on 9/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RequestCellDelegate <NSObject>

- (void)customAccessoryButtonTappedForIndex:(NSInteger)rowIndex;

@end

@interface RequestCell : UITableViewCell {
    
    __weak IBOutlet UILabel *lblRequestText;
    __weak IBOutlet UIButton *btnCustomAccessory;
    __weak IBOutlet UIImageView *imgViewProfile;
}

- (void)fillRequestCellWithRequest:(NSString *)strRequest
                   withIndexForRow:(NSInteger)rowIndex;

@property (assign, nonatomic) id<RequestCellDelegate> delegate;

@end
