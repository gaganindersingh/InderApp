//
//  BadgeView.m
//  TRAKKART
//
//  Created by Varun on 8/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
         badgeValue:(NSInteger)value {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithWhite:1.f alpha:0.4f]];
        
        UIFont *fontUsed = [UIFont fontWithName:_kFontBebasNeueBold size:25];
        
        CGSize sizeText = [APPUtility getSizeOfText:title
                                           forWidth:frame.size.width
                                           withFont:fontUsed];
        
        CGRect frameLabel = CGRectMake((frame.size.width - sizeText.width) / 2,
                                       (frame.size.height - sizeText.height) / 2,
                                       sizeText.width, sizeText.height + 4);
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:frameLabel];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setFont:fontUsed];
//        [lblTitle setFont:[UIFont systemFontOfSize:16]];
        [lblTitle setTextColor:[UIColor darkGrayColor]];
        [lblTitle setText:title];
        [self addSubview:lblTitle];
        
        if (value) {
            
            NSString *stringBadge = [NSString stringWithFormat:@"%ld", value];
            CGSize sizeBadge = [APPUtility getSizeOfText:stringBadge
                                                forWidth:80
                                                withFont:[UIFont systemFontOfSize:12]];
            
            CGRect frameBadge = CGRectMake(CGRectGetMaxX(frameLabel) - 5,
                                           CGRectGetMinY(frameLabel) - 2,
                                           sizeBadge.width + 5, sizeBadge.height);
            
            if (frameBadge.size.width <= frameBadge.size.height)
                frameBadge.size.width = frameBadge.size.height;
            
            UILabel *lblBadge = [[UILabel alloc] initWithFrame:frameBadge];
            [lblBadge setBackgroundColor:[UIColor redColor]];
            [lblBadge setTextAlignment:NSTextAlignmentCenter];
            [lblBadge setFont:[UIFont systemFontOfSize:12]];
            [lblBadge setTextColor:[UIColor whiteColor]];
            [lblBadge setClipsToBounds:YES];
            [lblBadge setText:stringBadge];
            
            [self addSubview:lblBadge];
            
            [lblBadge.layer setCornerRadius:frameBadge.size.height/2];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    
    UIColor *selectedColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    UIColor *simpleColor = [UIColor colorWithWhite:1.f alpha:0.4f];
    
    UIColor *colorSelected = selected ? selectedColor : simpleColor;
    [self setBackgroundColor:colorSelected];
}

@end
