//
//  WDCacheEngineManager.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDCacheEngineManager.h"

@implementation WDCacheEngineManager

+ (NSMutableDictionary *)sharedCache {
    static NSMutableDictionary *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [NSMutableDictionary new];
    });
    return sharedCache;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Get cached value -
// ----------------------------------------------------------------------------------------------------------------

+ (NSData *)cachedResultForQuery:(RACInternetQuery *)query {
    NSMutableDictionary *cache = [self sharedCache];
    NSString *cacheKey = [self stringFromQuery:query];
    NSArray *cachedQueryResultComponents;
    
    @synchronized(cache) {
        cachedQueryResultComponents = cache[cacheKey];
    }
    
    NSData *queryResult;
    if ([cachedQueryResultComponents count] > 1) {
        NSDate *queryResultExpirationDate = [cachedQueryResultComponents lastObject];
        queryResult = [queryResultExpirationDate compare:[NSDate date]] == NSOrderedAscending ? nil : [cachedQueryResultComponents firstObject];
    } else {
        queryResult = [cachedQueryResultComponents firstObject];
    }
    
    return queryResult;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Update cache -
// ----------------------------------------------------------------------------------------------------------------

+ (void)updateCacheWithResult:(NSData *)queryResult forQuery:(RACInternetQuery *)query {
    [self updateCacheWithResult:queryResult forQuery:query expirationTimeInterval:0];
}

+ (void)updateCacheWithResult:(NSData *)queryResult forQuery:(RACInternetQuery *)query expirationTimeInterval:(NSTimeInterval)expirationTimeInterval {
    if (!queryResult) {
        return;
    }
    
    NSMutableDictionary *cache = [self sharedCache];
    NSString *cacheKey = [self stringFromQuery:query];
    NSArray *cacheObject = expirationTimeInterval == 0 ? @[queryResult] : @[queryResult, [NSDate dateWithTimeIntervalSinceNow:expirationTimeInterval]];
    
    @synchronized(cache) {
        [cache setObject:cacheObject forKey:cacheKey];
    }
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Clear cache -
// ----------------------------------------------------------------------------------------------------------------

+ (void)clearCache {
    NSMutableDictionary *cache = [self sharedCache];
    
    @synchronized(cache) {
        [cache removeAllObjects];
    }
}

+ (void)clearCacheForQuery:(RACInternetQuery *)query {
    [self clearCacheForQuery:query ignoreParameters:NO];
}

+ (void)clearCacheForQuery:(RACInternetQuery *)query ignoreParameters:(BOOL)ignoreParameters {
    NSMutableDictionary *cache = [self sharedCache];
    NSString *cacheKey = ignoreParameters ? [[query serverUrl] lowercaseString] : [self stringFromQuery:query];
    
    @synchronized(cache) {
        NSArray *cacheKeysToRemove = [cache.allKeys filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
            return ignoreParameters ? [[evaluatedObject lowercaseString] containsString:cacheKey] : [[evaluatedObject lowercaseString] isEqualToString:cacheKey];
        }]];
        
        [cache removeObjectsForKeys:cacheKeysToRemove];
    }
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Helpers -
// ----------------------------------------------------------------------------------------------------------------

+ (NSString *)stringFromQuery:(RACInternetQuery *)query {
    NSDictionary *queryContent = [query queryContent];
    
    NSMutableArray *queryContentComponents = [NSMutableArray new];
    for (NSString *queryKey in queryContent) {
        [queryContentComponents addObject:[NSString stringWithFormat:@"%@ = %@", queryKey, queryContent[queryKey]]];
    }
    
    NSString *queryString = [@[[query serverUrl], [queryContentComponents componentsJoinedByString:@", "]] componentsJoinedByString:@" "];
    return [queryString lowercaseString];
}

@end
