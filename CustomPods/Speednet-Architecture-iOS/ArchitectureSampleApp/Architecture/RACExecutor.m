//
//  RACExecutor.m
//  ArchTest
//
//  Created by Konrad Roj on 16.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACExecutor.h"
#import "RACExecutor+Private.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACSubscriberCounter.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "RACExecutor+Private.h"
#import "RACNotifier.h"

@interface RACExecutor()
@property (strong, nonatomic) RACSubscriberCounter *internalSubscribersCount;
@end

@implementation RACExecutor

- (instancetype)init {
    self = [super init];
    if (self) {
        self.internalSubscribersCount = [RACSubscriberCounter new];
    }
    return self;
}

+ (instancetype)new {
    return [super new];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Signal -
// ----------------------------------------------------------------------------------------------------------------

- (RACSignal *)signal {
    RACSignal *executorSignal = [self prepareRACSignal];
    if (!executorSignal) {
        return nil;
    }

    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.internalSubscribersCount incrementCount];

        RACDisposable *subscriprionDisposable = [executorSignal subscribe:subscriber];

        @weakify(self);
        return [RACDisposable disposableWithBlock:^{
            @strongify(self);
            [subscriprionDisposable dispose];
            [self.internalSubscribersCount decrementCount];
        }];
    }];
}

- (RACSignal *)prepareRACSignal {
    @throw [NSException exceptionWithName:@"Not implemented method" reason:@"Metod \"prepareRACSignal\" not implemented" userInfo:nil];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Getters/Setters -
// ----------------------------------------------------------------------------------------------------------------

- (void)setSubscriberCounterBlock:(RACSubscriberCounterBlock)subscriberCounterBlock {
    self.internalSubscribersCount.subscriberCounterBlock = subscriberCounterBlock;
}

- (RACSubscriberCounterBlock)subscriberCounterBlock {
    return self.internalSubscribersCount.subscriberCounterBlock;
}

- (NSInteger)subscribersCount {
    return self.internalSubscribersCount.count;
}

@end
