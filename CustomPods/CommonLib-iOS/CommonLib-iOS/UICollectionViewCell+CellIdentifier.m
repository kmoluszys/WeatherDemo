//
//  UICollectionViewCell+CellIdentifier.m
//  CommonLib-iOS
//
//  Created by Grzegorz Sagadyn on 26.05.2015.
//  Copyright (c) 2015 Speednet Sp. z o.o. All rights reserved.
//

#import "UICollectionViewCell+CellIdentifier.h"

@implementation UICollectionViewCell (CellIdentifier)

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
