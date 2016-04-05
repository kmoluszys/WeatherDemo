//
//  WDCachedGetInternetQueryEngine.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDCachedGetInternetQueryEngine.h"
#import "WDCacheEngineManager.h"

@implementation WDCachedGetInternetQueryEngine

- (void)start {
    NSData *cachedQueryResult = [WDCacheEngineManager cachedResultForQuery:(RACInternetQuery *)self.query];
    
    if (cachedQueryResult) {
        [super handleResponse:nil responseObject:cachedQueryResult error:nil];
    } else {
        [super start];
    }
}

- (void)handleResponse:(NSURLResponse *)response responseObject:(NSData *)responseObject error:(NSError *)error {
    if (!error && response) {
        [WDCacheEngineManager updateCacheWithResult:responseObject forQuery:(RACInternetQuery *)self.query];
    }
    
    [super handleResponse:response responseObject:responseObject error:error];
}

@end
