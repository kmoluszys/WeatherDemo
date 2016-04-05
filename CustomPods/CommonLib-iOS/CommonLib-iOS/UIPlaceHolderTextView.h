//
//  UIPlaceHolderTextView.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 04/02/14.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView
@property (strong, nonatomic) NSString *placeholder;
@property (strong, nonatomic) UIColor *placeholderColor;

- (void)textChanged:(NSNotification*)notification;
- (void)scrollToVisibleCaretAnimated:(BOOL)animated;
- (void)scrollRangeToVisibleConsideringInsets:(NSRange)range animated:(BOOL)animated;

@end
