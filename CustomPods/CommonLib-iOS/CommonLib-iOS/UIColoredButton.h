//
//  ColoredButton.h
//  FotoKnudsen
//
//  Created by Maciej Duraziński on 09/06/14.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITouchButton.h"

/**
 * A subclass of UIButton with cusomized background colour.
 */
@interface UIColoredButton : UITouchButton

/**
 * Method used to set background colour for control state.
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
