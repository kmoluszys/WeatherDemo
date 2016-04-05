//
//  WDTimeoutCachedGetInternetQueryEngine.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDTimeoutCachedGetInternetQueryEngine.h"
#import "WDCacheEngineManager.h"

@interface WDTimeoutCachedGetInternetQueryEngine ()
@property (readwrite, assign, nonatomic) NSTimeInterval expirationTimeInterval;
@end

@implementation WDTimeoutCachedGetInternetQueryEngine

+ (instancetype)engineWithExpirationTimeInterval:(NSInteger)expirationTimeInterval {
    return [[[self class] alloc] initWithExpirationTimeInterval:expirationTimeInterval];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.expirationTimeInterval = 0;
    }
    
    return self;
}

- (instancetype)initWithExpirationTimeInterval:(NSInteger)expirationTimeInterval {
    self = [super init];
    if (self) {
        self.expirationTimeInterval = expirationTimeInterval;
    }
    
    return self;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Cache handling -
// ----------------------------------------------------------------------------------------------------------------

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
        [WDCacheEngineManager updateCacheWithResult:responseObject forQuery:(RACInternetQuery *)self.query expirationTimeInterval:self.expirationTimeInterval];
    }
    
    [super handleResponse:response responseObject:responseObject error:error];
}

@end
