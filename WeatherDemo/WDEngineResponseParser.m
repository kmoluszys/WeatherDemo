//
//  WDEngineResponseParser.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDEngineResponseParser.h"

@implementation WDEngineResponseParser

+ (NSDictionary *)parseResponse:(NSData *)response forQuery:(RACQuery *)query withError:(NSError **)error {
    NSError *deserializationError;
    NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&deserializationError];
    NSDictionary *result = [resultArray firstObject];
    
    if (deserializationError) {
        *error = deserializationError;
        return nil;
    }
    
    return result;
}

@end
