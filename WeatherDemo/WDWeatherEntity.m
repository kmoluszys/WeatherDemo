//
//  WDWeatherEntity.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDWeatherEntity.h"
#import "WDWeatherHttpEntity.h"

@implementation WDWeatherEntity

- (id<WDEntity>)entityWithHttpEntity:(WDWeatherHttpEntity *)httpEntity {
    self.temp = httpEntity.temp;
    self.type = [httpEntity.type integerValue];
    
    return self;
}

@end
