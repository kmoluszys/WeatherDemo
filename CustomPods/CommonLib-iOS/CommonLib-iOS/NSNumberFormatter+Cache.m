//
//  NSNumberFormatter+Cache.m
//  NavigatorTouch
//
//  Created by Karol Moluszys on 07.01.2014.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import "NSNumberFormatter+Cache.h"

@implementation NSNumberFormatter (Cache)

+ (NSMutableDictionary *)cachedFormatters {
    __strong static NSMutableDictionary *_formatters = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _formatters = [[NSMutableDictionary alloc] initWithCapacity:0];
    });
    
    return _formatters;
}

+ (NSNumberFormatter *)cachedFormatterWithNumberStyle:(NSNumberFormatterStyle)style {
    @synchronized([self cachedFormatters]) {
        if ([self cachedFormatters][[NSNumber numberWithInteger:style]]) {
            return [self cachedFormatters][[NSNumber numberWithInteger:style]];
        } else {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:style];
            [[self cachedFormatters] setObject:formatter forKey:[NSNumber numberWithInteger:style]];
            return formatter;
        }
    }
}

+ (NSNumber *)numberWithNumberStyle:(NSNumberFormatterStyle)style fromString:(NSString *)numberString {
    NSNumberFormatter *numberFormatter = [self cachedFormatterWithNumberStyle:style];
    return [numberFormatter numberFromString:numberString];
}

@end
