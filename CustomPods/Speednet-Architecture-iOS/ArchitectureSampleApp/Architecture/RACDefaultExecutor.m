//
//  RACLocalExecutor.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 10.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACDefaultExecutor.h"
#import "RACDefaultExecutor+Private.h"

@implementation RACDefaultExecutor

+ (instancetype)executorWithSyncBlock:(RACSyncExecutorBlock)syncExecutorBlock {
    RACDefaultExecutor *executor = [[[self class] alloc] init];
    executor.syncExecutorBlock = syncExecutorBlock;

    return executor;
}

+ (instancetype)executorWithAsyncBlock:(RACAsyncExecutorBlock)asyncExecutorBlock {
    RACDefaultExecutor *executor = [[[self class] alloc] init];
    executor.asyncExecutorBlock = asyncExecutorBlock;

    return executor;
}

@end
