//
//  RACHotExecutor.m
//  ArchTest
//
//  Created by Konrad Roj on 17.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACHotExecutor.h"
#import "RACDefaultExecutor+Private.h"
#import "RACColdExecutor.h"
#import "RACNull.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface RACHotExecutor()
@property (readwrite, strong, nonatomic) RACBehaviorSubject *behaviorSubject;
@property (strong, nonatomic) RACSignal *behaviorSubjectSignal;
@property (strong, nonatomic) RACDisposable *coldExecutorSubscriptionDisposable;
@property (strong, nonatomic) RACColdExecutor *coldExecutor;
@end

@implementation RACHotExecutor

+ (instancetype)executorWithColdExecutor:(RACColdExecutor *)coldExecutor {
    RACHotExecutor *executor = [self executorWithSyncBlock:nil];
    executor.coldExecutor = coldExecutor;

    return executor;
}

- (RACColdExecutor *)coldExecutor {
    if (!_coldExecutor && self.syncExecutorBlock) {
        _coldExecutor = [RACColdExecutor executorWithSyncBlock:self.syncExecutorBlock];
        self.syncExecutorBlock = nil;
    } else if (!_coldExecutor && self.asyncExecutorBlock) {
        _coldExecutor = [RACColdExecutor executorWithAsyncBlock:self.asyncExecutorBlock];
        self.asyncExecutorBlock = nil;
    } else if (!_coldExecutor) {
        @throw [NSException exceptionWithName:@"RACHotExecutor exception" reason:@"Cold executor is nil" userInfo:nil];
    }

    return _coldExecutor;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Prepare signal
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (RACSignal *)prepareRACSignal {
    RACSignal *resultSignal;

    @synchronized(self) {
        if (!self.behaviorSubject) {
            [self prepareBehaviorSubject];
        }

        if (!self.coldExecutorSubscriptionDisposable) {
            [self prepareColdSignalSubscription];
        }

        resultSignal = [self.behaviorSubjectSignal filter:^BOOL(id value) {
            return ![value isEqual:[RACNull null]];
        }];
    }

    return resultSignal;
}

- (void)prepareBehaviorSubject {
    self.behaviorSubject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:[RACNull null]];

    @weakify(self)
    self.behaviorSubjectSignal = [self.behaviorSubject doError:^(NSError *error) {
        @strongify(self)
        [self resetExecutor];
    }];

    self.behaviorSubjectSignal = [self.behaviorSubjectSignal doCompleted:^{
        @strongify(self)
        [self resetExecutor];
    }];

    [self.coldExecutorSubscriptionDisposable dispose];
    self.coldExecutorSubscriptionDisposable = nil;
}

- (void)prepareColdSignalSubscription {
    @weakify(self)
    self.coldExecutorSubscriptionDisposable = [self.coldExecutor.signal subscribeNext:^(id value) {
        @strongify(self)
        [self.behaviorSubject sendNext:value];
    } error:^(NSError *error) {
        @strongify(self)
        [self.behaviorSubject sendError:error];
    }];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Data changed
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (void)dataChanged:(RACColdExecutor *)coldExecutor {
    [self dataChanged:coldExecutor resetCache:NO];
}

- (void)dataChanged:(RACColdExecutor *)coldExecutor resetCache:(BOOL)resetCache {
    self.coldExecutor = coldExecutor;

    if (resetCache) {
        [self resetCache];
    }

    [self dataChanged];
}

- (void)dataChanged {
    [self.coldExecutorSubscriptionDisposable dispose];
    self.coldExecutorSubscriptionDisposable = nil;

    if (self.behaviorSubject != nil && self.subscribersCount > 0) {
        [self signal];
    }
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Reset methods
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (void)resetCache {
    [self.behaviorSubject sendNext:[RACNull null]];
}

- (void)resetExecutor {
    [self.coldExecutorSubscriptionDisposable dispose];
    self.coldExecutorSubscriptionDisposable = nil;
    self.behaviorSubjectSignal = nil;
    self.behaviorSubject = nil;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Dispose
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (void)dealloc {
    [self dispose];
}

- (void)dispose {
    [self.behaviorSubject sendCompleted];
    self.coldExecutor = nil;
}

@end
