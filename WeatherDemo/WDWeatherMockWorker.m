//
//  WDWeatherMockWorker.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDWeatherMockWorker.h"

@implementation WDWeatherMockWorker

- (RACExecutor *)getWeatherForLocation:(CLLocation *)location {
    return [RACColdExecutor executorWithAsyncBlock:^(RACNotifier *notifier) {
        [notifier sendSuccess:@{@"type": @(3), @"temp": @(-10.1)}];
    }];
}

@end
