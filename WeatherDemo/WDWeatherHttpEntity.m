//
//  WDWeatherHttpEntity.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDWeatherHttpEntity.h"

@implementation WDWeatherHttpEntity

+ (id<WDHttpEntity>)entityWithModel:(NSDictionary *)model {
    WDWeatherHttpEntity *entity = [[[self class] alloc] init];
    entity.temp = model[@"temp"];
    entity.type = model[@"type"];
    
    return entity;
}

@end
