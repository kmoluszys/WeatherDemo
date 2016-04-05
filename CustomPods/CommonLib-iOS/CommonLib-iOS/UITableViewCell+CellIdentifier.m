//
//  UITableViewCell+CellIdentifier.m
//  NetworkUp
//
//  Created by Grzegorz Sagadyn on 24.02.2015.
//  Copyright (c) 2015 NetworkUp. All rights reserved.
//

#import "UITableViewCell+CellIdentifier.h"

@implementation UITableViewCell (CellIdentifier)

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
