//
//  UIColor+Hex.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 09/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithHex:(NSString*)hexString;
+ (UIColor*)colorWithHex:(NSString*)hexString alpha:(CGFloat)alpha;
@end
