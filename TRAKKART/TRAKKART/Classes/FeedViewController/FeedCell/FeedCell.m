//
//  FeedCell.m
//  TRAKKART
//
//  Created by Varun on 8/12/2014.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "FeedCell.h"
#import "RequestCell.h"

@interface FeedCell () <UITableViewDelegate, UITableViewDataSource, RequestCellDelegate> {
    NSInteger feedType;
}

@end

static NSString *REUSEID_REQ = @"RequestCell";

@implementation FeedCell

- (void)awakeFromNib {
    // Initialization code
    
    [tableViewInCell registerNib:[UINib nibWithNibName:@"RequestCell" bundle:nil]
          forCellReuseIdentifier:REUSEID_REQ];
    [tableViewInCell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)fillFeedCellValuesForIndex:(NSInteger)indexValue
                         withTitle:(NSString *)title
                  withSelectedType:(NSInteger)selectedType {
    
    feedType = selectedType;
    [lblTitleForCell setText:title];
    [tableViewInCell reloadData];
}

#pragma mark - Request Cell Delegate

- (void)customAccessoryButtonTappedForIndex:(NSInteger)rowIndex {
    
    NSIndexPath *indexForRow = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    [tableViewInCell.delegate tableView:tableViewInCell
           editActionsForRowAtIndexPath:indexForRow];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = nil;
    if (feedType == 1) {
        RequestCell *cellReq = (RequestCell *)[tableViewInCell dequeueReusableCellWithIdentifier:REUSEID_REQ];
        NSString *strRequest = @"Brad Pitt wants to join your list \"Ki le ke aana?\"";
        [cellReq fillRequestCellWithRequest:strRequest withIndexForRow:indexPath.row];
        [cellReq setDelegate:self];
        cell = cellReq;
    }
    else {
        static NSString *cellID = @"Cell";
        UITableViewCell *cellSimple = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cellSimple)
            cellSimple = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cellSimple.textLabel setText:[NSString stringWithFormat:@"Index row : %ld", indexPath.row]];
        cell = cellSimple;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arrEditActions = nil;
    if (feedType == 1) {
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Accept" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // show UIActionSheet
    }];
    moreAction.backgroundColor = [UIColor colorWithRed:116/255.0f green:201/255.0f blue:0 alpha:1.0f];
    
    UITableViewRowAction *flagAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Reject" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // flag the row
    }];
    flagAction.backgroundColor = [UIColor colorWithRed:249/255.0f green:38/255.0f blue:0 alpha:1.0f];
    
        arrEditActions = @[moreAction, flagAction];
    }
    return arrEditActions;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
