//
//  UITableView+Animation.m
//  BPH
//
//  Created by Grzegorz Sagadyn on 16.10.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import "UITableView+Animation.h"
#import "NSTimer+Block.h"

@implementation UITableView (Animation)

- (void)reloadDataWithAnimation:(BOOL)animated {
	[self reloadDataWithAnimation:animated completionBlock:nil];
}

- (void)reloadDataWithAnimation:(BOOL)animated completionBlock:(void (^)(void))completionBlock {
	[self reloadData];
	
	if (animated) {
		CATransition *animation = [CATransition animation];
		[animation setType:kCATransitionFade];
		[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[animation setFillMode:kCAFillModeBoth];
		[animation setDuration:0.3f];
		[self.layer addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
		
		if (completionBlock) {
			[NSTimer scheduledTimerWithTimeInterval:animation.duration block:^(NSTimer *timer) {
				completionBlock();
			} repeats:NO];
		}
	}
}

@end
