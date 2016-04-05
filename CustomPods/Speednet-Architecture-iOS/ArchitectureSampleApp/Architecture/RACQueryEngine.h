//
//  SNQueryExecutor.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 09.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACQuery;
@class RACNotifier;

/**
 *  Executes query.
 */
@interface RACQueryEngine : NSObject

/**
 *  Notifier instance.
 */
@property (readonly, strong, nonatomic) RACNotifier *notifier;

/**
 *  Query list.
 */
@property (readonly, strong, nonatomic) NSArray *queries;

/**
 *  Last query from queries.
 */
@property (readonly, strong, nonatomic) RACQuery *query;

/**
 *  Determine if query is disposed.
 */
@property (readonly, assign, nonatomic, getter=isDisposed) BOOL disposed;

/**
 *  Starts executing query.
 */
- (void)start;

/**
 *  Cancel executing query.
 */
- (void)cancel;

@end
