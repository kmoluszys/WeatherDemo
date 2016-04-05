//
//  WDEntity.h
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

@protocol WDHttpEntity;

@protocol WDEntity <NSObject>

- (id<WDEntity>)entityWithHttpEntity:(id<WDHttpEntity>)httpEntity;

@end
