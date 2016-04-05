//
//  RACQueryNotifier.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACNotifier.h"

@class RACQuery;

@interface RACQueryNotifier : RACNotifier

/**
 *  Sends the next value to subscribers.
 *
 *  @param nextObject The value to send. This can be `nil`.
 */
- (void)sendNext:(RACQuery *)nextObject;

/**
 *  Sends the next value and completed to subscribers.
 *  This terminates the subscription, and invalidates the subscriber (such that it cannot subscribe to anything else in the future).
 *
 *  @param successObject The value to send. This can be `nil`.
 */
- (void)sendSuccess:(RACQuery *)successObject;

@end
