//
//  ColoredButton.m
//  FotoKnudsen
//
//  Created by Maciej Duraziński on 09/06/14.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import "UIColoredButton.h"

@interface UIColoredButton ()

/**
 * Dictionary used to store colours for control states.
 */
@property (strong, nonatomic) NSMutableDictionary *backgroundStates;

/**
 * Helper method used to return UIColor for control state.
 * @param state UIControlState for the color to return.
 */
- (UIColor *)backgroundColorForState:(UIControlState)state;

@end

@implementation UIColoredButton

- (NSMutableDictionary *)backgroundStates {
	if (_backgroundStates == nil) {
		_backgroundStates = [NSMutableDictionary dictionary];
	}
	
	return _backgroundStates;
}

- (UIColor *)backgroundColorForState:(UIControlState)state {
	return self.backgroundStates[@(state)];
}


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
	
	if (state == UIControlStateNormal) {
		self.backgroundColor = backgroundColor;
	}
	[self.backgroundStates setObject:backgroundColor forKey:@(state)];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	
	if (highlighted) {
		self.backgroundColor = self.backgroundStates[@(UIControlStateHighlighted)] ?: self.backgroundStates[@(UIControlStateNormal)];
	} else {
		self.backgroundColor = self.backgroundStates[@(UIControlStateNormal)];
	}
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	
	if (selected) {
		self.backgroundColor = self.backgroundStates[@(UIControlStateSelected)] ?: self.backgroundStates[@(UIControlStateNormal)];
	} else {
		self.backgroundColor = self.backgroundStates[@(UIControlStateNormal)];
	}
}

- (void)setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
	
	self.userInteractionEnabled = enabled;
	
	if (!enabled) {
		self.backgroundColor = self.backgroundStates[@(UIControlStateDisabled)] ?: self.backgroundStates[@(UIControlStateNormal)];
	} else {
		self.backgroundColor = self.backgroundStates[@(UIControlStateNormal)];
	}
}

@end
