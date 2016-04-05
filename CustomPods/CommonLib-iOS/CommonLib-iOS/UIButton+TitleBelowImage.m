//
//  UIButton+TitleBelowImage.m
//  NavigatorTouch
//
//  Created by Karol Moluszys on 12/9/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import "UIButton+TitleBelowImage.h"

@implementation UIButton (TitleBelowImage)

+ (UIButton *)buttonWithTitle:(NSString *)title belowImage:(UIImage *)image forControlState:(UIControlState)state {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:state];
    [button setTitle:title forState:state];
    
    // the space between the image and text
    CGFloat spacing = 6.0;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    return button;
    
}

- (UIButton *)setTitle:(NSString *)title belowImage:(UIImage *)image forControlState:(UIControlState)state {
    [self setImage:image forState:state];
    [self setTitle:title forState:state];
    
    // the space between the image and text
    CGFloat spacing = 6.0;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width + 2, - (imageSize.height + spacing), 2.0);
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width / 2.0;
    self.imageView.center = center;
    return self;
}

@end
