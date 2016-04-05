//
//  UITableView+Animation.h
//  BPH
//
//  Created by Grzegorz Sagadyn on 16.10.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Animation)

- (void)reloadDataWithAnimation:(BOOL)animated;
- (void)reloadDataWithAnimation:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

@end
