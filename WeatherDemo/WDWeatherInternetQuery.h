//
//  WDWeatherInternetQuery.h
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDBaseInternetQuery.h"

@interface WDWeatherInternetQuery : WDBaseInternetQuery
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;

@end
