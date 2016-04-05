//
//  RACQueryEngine+Private.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACQueryEngine.h"

@class RACQuery;
@class RACNotifier;

@interface RACQueryEngine ()
@property (assign, nonatomic) BOOL privateDisposed;

- (void)initializeEngineWithQueries:(NSArray *)queries notifier:(RACNotifier *)notifier;

@end
