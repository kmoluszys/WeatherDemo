//
//  FKButton.m
//  FotoKnudsen
//
//  Created by Maciej Duraziński on 30.06.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import "UITouchButton.h"

@interface UITouchButton ()
@property (strong, nonatomic) NSValue *internalAlignmentRectInsets;
@end

@implementation UITouchButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.hidden || !self.enabled || !self.userInteractionEnabled) {
        return nil;
    }

    CGRect largerFrame = [self adjustFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];

    return (CGRectContainsPoint(largerFrame, point) == YES) ? self : nil;
}

- (CGRect)adjustFrame:(CGRect)frame {
    int errorMarginWidth = MAX((44.0f - frame.size.width), 0) / 2.0f;
    int errorMarginHeight = MAX((44.0f - frame.size.height), 0) / 2.0f;

    return CGRectMake(frame.origin.x - errorMarginWidth, frame.origin.y - errorMarginHeight, frame.size.width + errorMarginWidth * 2.0f, frame.size.height + errorMarginHeight * 2.0f);
}

- (UIEdgeInsets)alignmentRectInsets {
    if (self.internalAlignmentRectInsets) {
        return [self.internalAlignmentRectInsets UIEdgeInsetsValue];
    } else {
        return [super alignmentRectInsets];
    }
}

- (void)setAlignmentRectInsets:(UIEdgeInsets)alignmentRectInsets {
    self.internalAlignmentRectInsets = [NSValue valueWithUIEdgeInsets:alignmentRectInsets];
    [self setNeedsDisplay];
}

@end
