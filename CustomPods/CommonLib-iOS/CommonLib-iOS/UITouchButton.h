//
//  FKButton.h
//  FotoKnudsen
//
//  Created by Maciej Duraziński on 30.06.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  A subclass of UIButton with minimum hit test of 44.0 x 44.0.
 */
@interface UITouchButton : UIButton
@property (assign, nonatomic) UIEdgeInsets alignmentRectInsets;

- (CGRect)adjustFrame:(CGRect)frame;

@end
