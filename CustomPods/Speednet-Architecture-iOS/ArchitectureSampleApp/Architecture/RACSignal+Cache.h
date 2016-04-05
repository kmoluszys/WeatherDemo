//
//  RACSignal+Cache.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 15.01.2016.
//  Copyright © 2016 Grzegorz Sagadyn. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@class RACCache;

@interface RACSignal (Cache)

+ (RACSignal *)cache:(RACCache *)cache objectForKey:(id<NSCopying>)cacheKey;
+ (RACSignal *)cache:(RACCache *)cache setCachedObject:(id)cacheObject forKey:(id<NSCopying>)cacheKey;
+ (RACSignal *)cache:(RACCache *)cache setCachedObject:(id)cacheObject forKey:(id<NSCopying>)cacheKey expirationTimeInterval:(NSTimeInterval)expirationTimeInterval;
+ (RACSignal *)clearCache:(RACCache *)cache;

- (RACSignal *)cache:(RACCache *)cache objectForKey:(id<NSCopying>)cacheKey;
- (RACSignal *)saveToCache:(RACCache *)cache forKey:(id<NSCopying>)cacheKey;
- (RACSignal *)saveToCache:(RACCache *)cache forKey:(id<NSCopying>)cacheKey expirationTimeInterval:(NSTimeInterval)expirationTimeInterval;
- (RACSignal *)clearCache:(RACCache *)cache;

@end
