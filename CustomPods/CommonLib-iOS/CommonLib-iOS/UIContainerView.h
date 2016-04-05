//
//  UIContainerView.h
//  Mobile Banking
//
//  Created by Grzegorz Sagadyn on 29.05.2015.
//  Copyright (c) 2015 Getin Group. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UIContainerViewAnimationNoneType,
    UIContainerViewAnimationFadeType,
    UIContainerViewAnimationEnterFromLeftSideType,
    UIContainerViewAnimationEnterFromRightSideType
} UIContainerViewAnimationType;

@interface UIContainerView : UIView
@property (weak, nonatomic) UIViewController *parentViewController;
@property (strong, nonatomic) UIViewController *embededViewController;

- (void)setEmbededViewController:(UIViewController *)embededViewController withAnimationType:(UIContainerViewAnimationType)animationType;

@end
