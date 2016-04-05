//
//  SNLabel.m
//  NavigatorTouch
//
//  Created by Karol Moluszys on 12/5/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import "UIInsetsLabel.h"

@implementation UIInsetsLabel

- (id)init {
    self = [super init];
    if (self) {
        self.padding = UIEdgeInsetsZero;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.padding = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.padding)];
}

- (void)struckThrough {
	NSMutableAttributedString *struckThroughString = [[NSMutableAttributedString alloc] initWithString:self.text];
	[struckThroughString addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [struckThroughString length])];

	self.text = nil;
	self.attributedText = struckThroughString;
}

- (void)setText:(NSString *)text {
	self.attributedText = nil;
	[super setText:text];
}

@end
