//
//  WDPresenterProvider.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDPresenterProvider.h"

@implementation WDPresenterProvider

+ (WDWeatherPresenter *)weatherPresenter {
    return [WDWeatherPresenter create];
}

@end
