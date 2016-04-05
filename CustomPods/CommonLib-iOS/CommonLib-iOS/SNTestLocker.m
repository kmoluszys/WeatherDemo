//
//  SNTestLocker.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 23/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import "SNTestLocker.h"

@interface SNTestLocker ()
@property (assign, nonatomic) NSUInteger expectedSignalCount;
@property (assign, nonatomic) NSUInteger signalCount;
@property (strong, nonatomic) NSDate *startTime;
@end

@implementation SNTestLocker

- (id)init {
    self = [super init];
    if (self) {
        _expectedSignalCount = 1;
		_signalCount = 0;
    }
    return self;
}

- (id)initWithExpectedSignalCount:(NSInteger)expectedSignalCount {
    self = [super init];
    if (self) {
        _expectedSignalCount = expectedSignalCount;
		_signalCount = 0;
    }
    return self;
}

- (void)wait {
    while(_expectedSignalCount > _signalCount) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (BOOL)waitWithTimeout:(NSTimeInterval)timeout {
    NSDate *startTime = [NSDate date];
    while(_expectedSignalCount > _signalCount) {
        if ([[NSDate date] timeIntervalSinceDate:startTime] > timeout) {
            return NO;
        }
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.01]];
    }
    
    return YES;
}

- (void)signal {
    _signalCount++;
}

- (void)resetSignalCounter {
	_signalCount = 0;
}

@end
