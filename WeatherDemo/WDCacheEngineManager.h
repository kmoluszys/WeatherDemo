//
//  WDCacheEngineManager.h
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDCacheEngineManager : NSObject

+ (NSData *)cachedResultForQuery:(RACInternetQuery *)query;

+ (void)updateCacheWithResult:(NSData *)queryResult forQuery:(RACInternetQuery *)query;
+ (void)updateCacheWithResult:(NSData *)queryResult forQuery:(RACInternetQuery *)query expirationTimeInterval:(NSTimeInterval)expirationTimeInterval;

+ (void)clearCache;
+ (void)clearCacheForQuery:(RACInternetQuery *)query;
+ (void)clearCacheForQuery:(RACInternetQuery *)query ignoreParameters:(BOOL)ignoreParameters;

@end
