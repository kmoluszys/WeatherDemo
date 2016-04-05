//
//  SNQueryExecutor.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 09.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACQueryEngine.h"
#import "RACQueryEngine+Private.h"
#import "RACQuery.h"
#import "RACNotifier.h"

@interface RACQueryEngine ()
@property (readwrite, strong, nonatomic) RACNotifier *notifier;
@property (readwrite, strong, nonatomic) NSArray *queries;
@end

@implementation RACQueryEngine

- (void)initializeEngineWithQueries:(NSArray *)queries notifier:(RACNotifier *)notifier {
    self.notifier = notifier;
    self.queries = queries;
    self.privateDisposed = NO;
}

- (RACQuery *)query {
    return [self.queries lastObject];
}

- (BOOL)isDisposed {
    return self.privateDisposed;
}

- (void)start {
}

- (void)cancel {
}

@end
