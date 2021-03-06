//
//  RequestCell.m
//  TRAKKART
//
//  Created by Varun on 9/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "RequestCell.h"

@implementation RequestCell

- (void)awakeFromNib {
    // Initialization code
    [lblRequestText setFont:[UIFont fontWithName:_kFontBebasNeueRegular size:22]];
    
    [imgViewProfile.layer setCornerRadius:25.0f];
    [imgViewProfile.layer setBorderColor:[UIColor blackColor].CGColor];
    [imgViewProfile.layer setBorderWidth:0.5f];
    
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillRequestCellWithRequest:(NSString *)strRequest
                   withIndexForRow:(NSInteger)rowIndex {
    
    [lblRequestText setText:strRequest];
    [btnCustomAccessory setTag:rowIndex];
}

#pragma mark - Edit Button Action

- (IBAction)editButtonActionOnCell:(id)sender {
    if ([_delegate respondsToSelector:@selector(customAccessoryButtonTappedForIndex:)])
        [_delegate customAccessoryButtonTappedForIndex:[sender tag]];
}

@end
