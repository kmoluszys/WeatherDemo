//
//  NSTimer+Block.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 17/01/14.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Block)

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)inRepeats;
+ (instancetype)scheduledTimerInRunLoop:(NSRunLoop *)runLoop withTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))block repeats:(BOOL)inRepeats;
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)inRepeats;

@end
