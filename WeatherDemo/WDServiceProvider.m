//
//  WDServiceProvider.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDServiceProvider.h"

@implementation WDServiceProvider

+ (WDLocationService *)locationService {
    return [WDLocationService createWithType:SNArchitectureStateComponentPermanentType];
}

+ (WDWeatherService *)weatherService {
    return [WDWeatherService create];
}

@end
