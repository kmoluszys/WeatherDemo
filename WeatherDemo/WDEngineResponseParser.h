//
//  WDEngineResponseParser.h
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDEngineResponseParser : NSObject

+ (NSDictionary *)parseResponse:(NSData *)response forQuery:(RACQuery *)query withError:(NSError **)error;

@end
