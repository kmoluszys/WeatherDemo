//
//  RACSignal+Tools.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 09.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACSignal+Tools.h"
#import "RACNotifier.h"

@implementation RACSignal (Tools)

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Flatten map
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (RACSignal *)flattenMapWithSyncBlock:(RACFlattenSyncExecutorBlock)block {
    return [self flattenMap:^RACStream *(id value) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSError *error = nil;
            id result =  block(value, &error);

            if (!error) {
                [subscriber sendNext:result];
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:error];
            }

            return nil;
        }];
    }];
}

- (RACSignal *)flattenMapWithAsyncBlock:(RACFlattenAsyncExecutorBlock)block {
    return [self flattenMap:^RACStream *(id value) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            RACNotifier *notifier = [RACNotifier notifierWithSubscriber:subscriber];

            block(value, notifier);

            return nil;
        }];
    }];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Subscribe
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (RACDisposable *)subscribe {
    return [self subscribeNext:^(id x) {
    }];
}

- (RACSignal *)subscribeOnMainThread {
    return [self subscribeOn:[RACScheduler mainThreadScheduler]];
}

- (RACSignal *)subscribeOnBackgroundThread {
    return [self subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Omit errors
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (RACSignal *)omitError {
    return [self catchTo:[RACSignal empty]];
}

- (RACSignal *)omitErrorByValue:(id)defaultValue {
    return [self catch:^RACSignal *(NSError *error) {
        return [RACSignal return:defaultValue];
    }];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Next signal -
// ----------------------------------------------------------------------------------------------------------------

+ (RACSignal *)next:(id)value {
	return [RACSignal return:value];
}

@end
