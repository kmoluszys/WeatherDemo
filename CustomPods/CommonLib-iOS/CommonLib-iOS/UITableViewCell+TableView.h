//
//  UITableViewCell+TableView.h
//  FotoKnudsen
//
//  Created by Grzegorz Sagadyn on 09.07.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (TableView)
@property (readonly, strong, nonatomic) NSIndexPath *indexPath;
@property (readonly, strong, nonatomic) UITableView *tableView;

@end
