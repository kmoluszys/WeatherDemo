//
//  WDWeatherService.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDWeatherService.h"
#import "WDWeatherHttpEntity.h"
#import "WDWeatherEntity.h"

@implementation WDWeatherService

- (RACSignal *)getWeatherForLocation:(CLLocation *)location {
    RACExecutor *executor = [[WDWorkerProvider weatherWorker] getWeatherForLocation:location];
    
    return [[executor.signal map:^id(NSDictionary *response) {
        WDWeatherHttpEntity *httpEntity = [WDWeatherHttpEntity entityWithModel:response];
        return httpEntity;
    }] map:^id(WDWeatherHttpEntity *httpEntity) {
        WDWeatherEntity *entity = [[WDWeatherEntity new] entityWithHttpEntity:httpEntity];
        return entity;
    }];
}

@end
