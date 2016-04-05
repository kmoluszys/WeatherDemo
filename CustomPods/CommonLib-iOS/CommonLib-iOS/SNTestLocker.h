//
//  SNTestLocker.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 23/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNTestLocker : NSObject

- (id)initWithExpectedSignalCount:(NSInteger)expectedSignalCount;
- (void)wait;
- (BOOL)waitWithTimeout:(NSTimeInterval)timeout;
- (void)signal;
- (void)resetSignalCounter;

@end
