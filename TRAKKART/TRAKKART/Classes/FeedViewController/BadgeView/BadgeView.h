//
//  BadgeView.h
//  TRAKKART
//
//  Created by Varun on 8/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView

- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
         badgeValue:(NSInteger)badgeValue;
- (void)setSelected:(BOOL)selected;

@end
