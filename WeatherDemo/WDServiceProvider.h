//
//  WDServiceProvider.h
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import <Speednet-Architecture-iOS/Speednet-Architecture-iOS.h>
#import "WDLocationService.h"
#import "WDWeatherService.h"

@interface WDServiceProvider : SNServiceProvider

+ (WDLocationService *)locationService;
+ (WDWeatherService *)weatherService;

@end
