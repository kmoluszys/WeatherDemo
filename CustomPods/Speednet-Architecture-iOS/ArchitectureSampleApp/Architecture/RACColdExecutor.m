//
//  RACColdExecutor.m
//  ArchTest
//
//  Created by Konrad Roj on 16.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACColdExecutor.h"
#import "RACDefaultExecutor+Private.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACNotifier.h"

@implementation RACColdExecutor

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Prepare signal
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (RACSignal *)prepareRACSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (self.syncExecutorBlock) {
            [self syncSignalHandler:subscriber];
        } else if (self.asyncExecutorBlock) {
            [self asyncSignalHandler:subscriber];
        } else {
            @throw [NSException exceptionWithName:@"Block Exception" reason:[NSString stringWithFormat:@"There isn't any block"] userInfo:nil];
        }

        return nil;
    }];
}

- (void)syncSignalHandler:(id<RACSubscriber>)subscriber {
    NSError *error = nil;
    id result = self.syncExecutorBlock(&error);

    if (!error) {
        [subscriber sendNext:result];
        [subscriber sendCompleted];
    } else {
        [subscriber sendError:error];
    }
}

- (void)asyncSignalHandler:(id<RACSubscriber>)subscriber {
    RACNotifier *notifier = [RACNotifier notifierWithSubscriber:subscriber];
    self.asyncExecutorBlock(notifier);
}

@end

