//
//  WDWeatherEntity.h
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDEntity.h"

typedef enum : NSUInteger {
    WDWeatherTypeUnknown,
    WDWeatherTypeSunny,
    WDWeatherTypeCloudy,
    WDWeatherTypeRainy,
} WDWeatherType;

@interface WDWeatherEntity : NSObject <WDEntity>
@property (strong, nonatomic) NSNumber *temp;
@property (assign, nonatomic) WDWeatherType type;

@end
