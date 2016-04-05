//
//  RACHotExecutor.h
//  ArchTest
//
//  Created by Konrad Roj on 17.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACDefaultExecutor.h"

@class RACSignal;
@class RACColdExecutor;
@class RACBehaviorSubject;

/**
 *  Executes the work specified in synchronus/asynchronus block or in cold executor. Can sends the last value it received when it is subscribed to.
 */
@interface RACHotExecutor : RACDefaultExecutor

/**
 *  A behavior subject.
 */
@property (readonly, strong, nonatomic) RACBehaviorSubject *behaviorSubject;

/**
 *  Create instance of hot executor.
 *
 *  @param coldExecutor Cold executor.
 *
 *  @return Hot executor instance.
 */
+ (instancetype)executorWithColdExecutor:(RACColdExecutor *)coldExecutor;

/**
 *  Invokes cold executor and notifies about changes subscribers.
 *
 *  @param coldExecutor Cold executor.
 */
- (void)dataChanged:(RACColdExecutor *)coldExecutor;

/**
 *  Invokes cold executor and notifies about changes subscribers.
 *
 *  @param coldExecutor Cold executor.
 *  @param resetCache   Determine if executor cache should be cleared.
 */
- (void)dataChanged:(RACColdExecutor *)coldExecutor resetCache:(BOOL)resetCache;

/**
 *  Invokes cold executor and notifies about changes subscribers.
 */
- (void)dataChanged;

/**
 *  Resets executor chache.
 */
- (void)resetCache;

/**
 *  Performs the disposal work. Can be called multiple times, though subsequent calls won't do anything.
 */
- (void)dispose;

@end
