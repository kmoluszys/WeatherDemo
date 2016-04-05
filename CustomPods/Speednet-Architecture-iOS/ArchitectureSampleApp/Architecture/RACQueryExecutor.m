//
//  RACQueryExecutor.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACQueryExecutor.h"
#import "RACExecutor+Private.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACQueryEngine+Private.h"
#import "RACNotifier.h"
#import "RACQueryNotifier.h"

@interface RACQueryExecutor ()
@property (strong, nonatomic) RACQueryEngine *engine;
@property (copy, nonatomic) RACQueryExecutorBlock queryExecutorBlock;
@end

@implementation RACQueryExecutor

+ (instancetype)executorWithEngine:(RACQueryEngine *)engine queryBlock:(RACQueryExecutorBlock)queryExecutorBlock {
    RACQueryExecutor *executor = [[[self class] alloc] init];
    executor.queryExecutorBlock = queryExecutorBlock;
    executor.engine = engine;

    return executor;
}

- (RACSignal *)prepareRACSignal {
    return [[[self querySignalHandler] collect] flattenMap:^RACStream *(NSArray *queries) {
        return [self engineSignalHandlerWithQueries:queries];
    }];
}

- (RACSignal *)querySignalHandler {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RACQueryNotifier *notifier = [RACQueryNotifier notifierWithSubscriber:subscriber];
        self.queryExecutorBlock(notifier);

        return nil;
    }];
}

- (RACSignal *)engineSignalHandlerWithQueries:(NSArray *)queries {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.engine initializeEngineWithQueries:queries notifier:[RACNotifier notifierWithSubscriber:subscriber]];

        [self.engine start];

        return [RACDisposable disposableWithBlock:^{
            self.engine.privateDisposed = YES;
            [self.engine cancel];
        }];

    }];
}

@end
