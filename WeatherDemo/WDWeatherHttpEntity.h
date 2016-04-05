//
//  WDWeatherHttpEntity.h
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDHttpEntity.h"

@interface WDWeatherHttpEntity : NSObject <WDHttpEntity>
@property (strong, nonatomic) NSNumber *temp;
@property (strong, nonatomic) NSNumber *type;

@end
