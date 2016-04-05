//
//  RACNotifier.h
//  ArchTest
//
//  Created by Konrad Roj on 26.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RACSubscriber;

/**
 *  Represents any object which can directly receive values from a RACSignal.
 */
@interface RACNotifier : NSObject

/**
 *  Initialize notifier object
 *
 *  @param subscriber Subscriber object. This shouldn't be `nil`.
 *
 *  @return Instance of the notifier.
 */
+ (instancetype)notifierWithSubscriber:(id<RACSubscriber>)subscriber;

/**
 *  Sends the next value to subscribers.
 *
 *  @param nextObject The value to send. This can be `nil`.
 */
- (void)sendNext:(id)nextObject;

/**
 *  Sends the next value and completed to subscribers.
 *  This terminates the subscription, and invalidates the subscriber (such that it cannot subscribe to anything else in the future).
 *
 *  @param successObject The value to send. This can be `nil`.
 */
- (void)sendSuccess:(id)successObject;

/**
 *  Sends completed to subscribers.
 *  This terminates the subscription, and invalidates the subscriber (such that it cannot subscribe to anything else in the future).
 */
- (void)sendCompleted;

/**
 *  Sends the error to subscribers.
 *  This terminates the subscription, and invalidates the subscriber (such that it cannot subscribe to anything else in the future).
 *
 *  @param error The error to send. This can be `nil`.
 */
- (void)sendError:(NSError *)error;

@end
