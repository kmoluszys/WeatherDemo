//
//  WDWeatherWorker.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDWeatherWorker.h"
#import "WDJsonGetInternetQueryEngine.h"
#import "WDWeatherInternetQuery.h"
#import "WDCachedGetInternetQueryEngine.h"
#import "WDTimeoutCachedGetInternetQueryEngine.h"

@implementation WDWeatherWorker

- (RACExecutor *)getWeatherForLocation:(CLLocation *)location {
    return [RACQueryExecutor executorWithEngine:[WDJsonGetInternetQueryEngine new] queryBlock:^(RACQueryNotifier *notifier) {
        WDWeatherInternetQuery *query = [WDWeatherInternetQuery new];
        query.lat = [@(location.coordinate.latitude) stringValue];
        query.lon = [@(location.coordinate.longitude) stringValue];
        
        [notifier sendSuccess:query];
    }];
}

@end
