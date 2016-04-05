//
//  UIButton+TitleBelowImage.h
//  NavigatorTouch
//
//  Created by Karol Moluszys on 12/9/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TitleBelowImage)
+ (UIButton *)buttonWithTitle:(NSString *)title belowImage:(UIImage *)image forControlState:(UIControlState)state;
- (UIButton *)setTitle:(NSString *)title belowImage:(UIImage *)image forControlState:(UIControlState)state;
@end
