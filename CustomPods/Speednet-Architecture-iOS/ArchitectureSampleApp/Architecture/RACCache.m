//
//  RACCache.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 15.01.2016.
//  Copyright © 2016 Grzegorz Sagadyn. All rights reserved.
//

#import "RACCache.h"

@interface RACCache ()
@property (strong, nonatomic) NSMutableDictionary *cacheDictionary;
@property (nonatomic, assign) dispatch_once_t onceToken;
@end

@implementation RACCache

+ (RACCache *)sharedCache {
    static RACCache *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [RACCache new];
    });
    return sharedCache;
}

- (NSMutableDictionary *)cacheDictionary {
    dispatch_once(&_onceToken, ^{
        _cacheDictionary = [NSMutableDictionary new];
    });
    
    return _cacheDictionary;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Get cached object -
// ----------------------------------------------------------------------------------------------------------------

- (id)cachedObjectForKey:(id<NSCopying>)cacheKey {
    NSMutableDictionary *cache = self.cacheDictionary;
    NSArray *cacheResultComponents;
    
    @synchronized(cache) {
        cacheResultComponents = cache[cacheKey];
    }
    
    NSData *queryResult;
    if ([cacheResultComponents count] > 1) {
        NSDate *queryResultExpirationDate = [cacheResultComponents lastObject];
        queryResult = [queryResultExpirationDate compare:[NSDate date]] == NSOrderedAscending ? nil : [cacheResultComponents firstObject];
    } else {
        queryResult = [cacheResultComponents firstObject];
    }
    
    return queryResult;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Set cache object -
// ----------------------------------------------------------------------------------------------------------------

- (void)setCachedObject:(id)cacheObject forKey:(id<NSCopying>)cacheKey {
    [self setCachedObject:cacheObject forKey:cacheKey expirationTimeInterval:0];
}

- (void)setCachedObject:(id)cacheObject forKey:(id<NSCopying>)cacheKey expirationTimeInterval:(NSTimeInterval)expirationTimeInterval {
    NSMutableDictionary *cache = self.cacheDictionary;
    if (cacheKey && cacheObject) {
        NSArray *cacheArray = expirationTimeInterval == 0 ? @[cacheObject] : @[cacheObject, [NSDate dateWithTimeIntervalSinceNow:expirationTimeInterval]];
        
        @synchronized(cache) {
            [cache setObject:cacheArray forKey:cacheKey];
        }
    } else if (cacheKey && !cacheObject) {
        @synchronized(cache) {
            [cache removeObjectForKey:cacheKey];
        }
    }
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Clear cache -
// ----------------------------------------------------------------------------------------------------------------

- (void)clearCache {
    @synchronized(self.cacheDictionary) {
        [self.cacheDictionary removeAllObjects];
    }
}

@end
