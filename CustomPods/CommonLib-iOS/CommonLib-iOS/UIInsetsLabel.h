//
//  SNLabel.h
//  NavigatorTouch
//
//  Created by Karol Moluszys on 12/5/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIInsetsLabel : UILabel
@property (assign, nonatomic) UIEdgeInsets padding;

- (void)struckThrough;

@end
