//
//  NSTimer+Block.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 17/01/14.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))block repeats:(BOOL)inRepeats {
    NSParameterAssert(block != nil);
    return [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeBlockFromTimer:) userInfo:[block copy] repeats:inRepeats];
}

+ (instancetype)scheduledTimerInRunLoop:(NSRunLoop *)runLoop withTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))block repeats:(BOOL)inRepeats {
    NSParameterAssert(block != nil);
    NSTimer *timer = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(executeBlockFromTimer:) userInfo:[block copy] repeats:inRepeats];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
    
    return timer;
}

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))block repeats:(BOOL)inRepeats {
    NSParameterAssert(block != nil);
    return [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(executeBlockFromTimer:) userInfo:[block copy] repeats:inRepeats];
}

+ (void)executeBlockFromTimer:(NSTimer *)aTimer {
    void (^block)(NSTimer *) = [aTimer userInfo];
    if (block) block(aTimer);
}

@end
