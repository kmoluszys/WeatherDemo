//
//  WDTimeoutCachedGetInternetQueryEngine.h
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDCachedGetInternetQueryEngine.h"

@interface WDTimeoutCachedGetInternetQueryEngine : WDJsonGetInternetQueryEngine
@property (readonly, assign, nonatomic) NSTimeInterval expirationTimeInterval;

+ (instancetype)engineWithExpirationTimeInterval:(NSInteger)expirationTimeInterval;

- (instancetype)initWithExpirationTimeInterval:(NSInteger)expirationTimeInterval;

@end
