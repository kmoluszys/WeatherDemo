//
//  RACSignal+Cache.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 15.01.2016.
//  Copyright © 2016 Grzegorz Sagadyn. All rights reserved.
//

#import "RACSignal+Cache.h"
#import "RACCache.h"

@implementation RACSignal (Cache)

+ (RACSignal *)cache:(RACCache *)cache objectForKey:(id<NSCopying>)cacheKey {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:[cache cachedObjectForKey:cacheKey]];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

+ (RACSignal *)cache:(RACCache *)cache setCachedObject:(id)cacheObject forKey:(id<NSCopying>)cacheKey {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [cache setCachedObject:cacheObject forKey:cacheKey];
        
        [subscriber sendNext:cacheObject];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

+ (RACSignal *)cache:(RACCache *)cache setCachedObject:(id)cacheObject forKey:(id<NSCopying>)cacheKey expirationTimeInterval:(NSTimeInterval)expirationTimeInterval {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [cache setCachedObject:cacheObject forKey:cacheKey expirationTimeInterval:expirationTimeInterval];
        
        [subscriber sendNext:cacheObject];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

+ (RACSignal *)clearCache:(RACCache *)cache {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [cache clearCache];
        
        [subscriber sendNext:@(YES)];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

- (RACSignal *)cache:(RACCache *)cache objectForKey:(id<NSCopying>)cacheKey {
    return [self map:^id(id value) {
        [cache cachedObjectForKey:cacheKey];
        return value;
    }];
}

- (RACSignal *)saveToCache:(RACCache *)cache forKey:(id<NSCopying>)cacheKey {
    return [self map:^id(id value) {
        [cache setCachedObject:value forKey:cacheKey];
        return value;
    }];
}

- (RACSignal *)saveToCache:(RACCache *)cache forKey:(id<NSCopying>)cacheKey expirationTimeInterval:(NSTimeInterval)expirationTimeInterval {
    return [self map:^id(id value) {
        [cache setCachedObject:value forKey:cacheKey expirationTimeInterval:expirationTimeInterval];
        return value;
    }];
}

- (RACSignal *)clearCache:(RACCache *)cache {
    return [self map:^id(id value) {
        [cache clearCache];
        return value;
    }];
}

@end
