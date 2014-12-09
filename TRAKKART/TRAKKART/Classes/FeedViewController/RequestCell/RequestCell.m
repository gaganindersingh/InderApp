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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillRequestCellWithRequest:(NSString *)strRequest {
    [lblRequestText setText:strRequest];
}

@end
