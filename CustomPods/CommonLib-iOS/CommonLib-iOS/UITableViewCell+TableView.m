//
//  UITableViewCell+TableView.m
//  FotoKnudsen
//
//  Created by Grzegorz Sagadyn on 09.07.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import "UITableViewCell+TableView.h"

@implementation UITableViewCell (TableView)

- (NSIndexPath *)indexPath {
    UITableView *tableView = self.tableView;
    return [tableView indexPathForCell:self] ?: [tableView indexPathForRowAtPoint:self.center];
}

- (UITableView *)tableView {
	UIView *superView = self.superview;
	
    while (superView && ![superView isKindOfClass:[UITableView class]]) {
        superView = superView.superview;
    }
	
    if (superView) {
        return (UITableView *)superView;
    }
	
    return nil;
}

@end
