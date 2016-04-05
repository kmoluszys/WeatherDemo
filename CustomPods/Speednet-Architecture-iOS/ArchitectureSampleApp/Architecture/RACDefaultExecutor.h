//
//  RACLocalExecutor.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 10.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACExecutor.h"

@class RACNotifier;

typedef id (^RACSyncExecutorBlock) (NSError **error);
typedef void (^RACAsyncExecutorBlock) (RACNotifier *notifier);

/**
 *  Abstract default executor
 */
@interface RACDefaultExecutor : RACExecutor

/**
 *  Create instance of cold executor.
 *
 *  @param syncExecutorBlock Synchronized performed block.
 *
 *  @return Cold executor instance.
 */
+ (instancetype)executorWithSyncBlock:(RACSyncExecutorBlock)syncExecutorBlock;

/**
 *  Create instance of cold executor.
 *
 *  @param asyncExecutorBlock Asynchronized performed block.
 *
 *  @return Cold executor instance.
 */
+ (instancetype)executorWithAsyncBlock:(RACAsyncExecutorBlock)asyncExecutorBlock;

@end
