//
//  RACNotifier.m
//  ArchTest
//
//  Created by Konrad Roj on 26.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACNotifier.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACNotifier()
@property (strong, nonatomic) id<RACSubscriber> subscriber;
@end

@implementation RACNotifier

+ (instancetype)notifierWithSubscriber:(id<RACSubscriber>)subscriber {
    RACNotifier *notifier = [[[self class] alloc] init];
    notifier.subscriber = subscriber;

    return notifier;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Subscriber handler
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (void)sendNext:(id)nextObject {
    [self.subscriber sendNext:nextObject];
}

- (void)sendSuccess:(id)successObject {
    [self.subscriber sendNext:successObject];
    [self.subscriber sendCompleted];
}

- (void)sendCompleted {
    [self.subscriber sendCompleted];
}

- (void)sendError:(NSError *)error {
    NSLog(@"Notifier sends error: %@", error);
    [self.subscriber sendError:error];
}

@end
