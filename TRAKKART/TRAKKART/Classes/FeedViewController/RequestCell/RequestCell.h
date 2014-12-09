//
//  RequestCell.h
//  TRAKKART
//
//  Created by Varun on 9/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestCell : UITableViewCell {
    
    __weak IBOutlet UILabel *lblRequestText;
}

- (void)fillRequestCellWithRequest:(NSString *)strRequest;

@end
