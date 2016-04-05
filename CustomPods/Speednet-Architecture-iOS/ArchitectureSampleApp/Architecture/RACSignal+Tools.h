//
//  RACSignal+Tools.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 09.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@class RACNotifier;

typedef id (^RACFlattenSyncExecutorBlock)(id value, NSError **error);
typedef void (^RACFlattenAsyncExecutorBlock)(id value, RACNotifier *notifier);

@interface RACSignal (Tools)

- (RACSignal *)flattenMapWithSyncBlock:(RACFlattenSyncExecutorBlock)block;
- (RACSignal *)flattenMapWithAsyncBlock:(RACFlattenAsyncExecutorBlock)block;

- (RACDisposable *)subscribe;
- (RACSignal *)subscribeOnMainThread;
- (RACSignal *)subscribeOnBackgroundThread;

- (RACSignal *)omitError __deprecated_msg("Use catchTo:");
- (RACSignal *)omitErrorByValue:(id)defaultValue __deprecated_msg("Use catch:");

+ (RACSignal *)next:(id)value __deprecated_msg("Use return:");

@end
