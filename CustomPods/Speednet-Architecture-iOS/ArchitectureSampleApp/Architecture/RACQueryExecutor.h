//
//  RACQueryExecutor.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACExecutor.h"

@class RACQuery;
@class RACQueryNotifier;
@class RACQueryEngine;

typedef void (^RACQueryExecutorBlock) (RACQueryNotifier *notifier);

/**
 *  Executes the work specified in block using engine.
 */
@interface RACQueryExecutor : RACExecutor

/**
 *  Create instance of query executor.
 *
 *  @param engine             Engine instance.
 *  @param queryExecutorBlock Cold executor.
 *
 *  @return Query executor instance.
 */
+ (instancetype)executorWithEngine:(RACQueryEngine *)engine queryBlock:(RACQueryExecutorBlock)queryExecutorBlock;

@end
