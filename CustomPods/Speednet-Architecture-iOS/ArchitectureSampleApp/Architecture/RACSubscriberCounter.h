//
//  RACSubscriberCounter.h
//  ArchTest
//
//  Created by Konrad Roj on 26.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RACSubscriberCounterBlock) (NSUInteger observablesCount);

/**
 *  Subscription counter.
 */
@interface RACSubscriberCounter : NSObject

/**
 *  Block which is called every time while subscriber count did change.
 */
@property (strong, nonatomic) RACSubscriberCounterBlock subscriberCounterBlock;

/**
 *  Count value.
 */
@property (readonly, assign, atomic) NSInteger count;

/**
 *  Increment counter.
 */
- (void)incrementCount;

/**
 *  Decrement counter.
 */
- (void)decrementCount;

@end
