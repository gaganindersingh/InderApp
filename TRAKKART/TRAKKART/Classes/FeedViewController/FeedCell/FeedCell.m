//
//  FeedCell.m
//  TRAKKART
//
//  Created by Varun on 8/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "FeedCell.h"

@interface FeedCell () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation FeedCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)fillFeedCellValuesForIndex:(NSInteger)indexValue {
    
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    [cell.textLabel setText:[NSString stringWithFormat:@"Index row : %ld", indexPath.row]];
    return cell;
}

@end
