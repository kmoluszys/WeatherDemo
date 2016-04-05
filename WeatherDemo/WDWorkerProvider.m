//
//  WDWorkerProvider.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDWorkerProvider.h"

@implementation WDWorkerProvider

+ (WDWeatherWorker *)weatherWorker {
    return [WDWeatherWorker create];
}

@end
