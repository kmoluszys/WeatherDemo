//
//  NSDateFormatter+Cache.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 17/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import "NSDateFormatter+Cache.h"

@implementation NSDateFormatter (Cache)

+ (NSMutableDictionary *)cachedFormatters {
	__strong static NSMutableDictionary *_formatters = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_formatters = [[NSMutableDictionary alloc] initWithCapacity:0];
	});
    
	return _formatters;
}

+ (NSDateFormatter *)cachedFormatterWithDateFormat:(NSString *)dateFormat {
    @synchronized([self cachedFormatters]) {
        if ([self cachedFormatters][dateFormat]) {
            return [self cachedFormatters][dateFormat];
        } else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:dateFormat];
            [[self cachedFormatters] setObject:formatter forKey:dateFormat];
            return formatter;
        }
    }
}

+ (NSDateFormatter *)cachedFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    @synchronized([self cachedFormatters]) {
        if ([self cachedFormatters][[NSString stringWithFormat:@"%ld-%ld", (long)dateStyle, (long)timeStyle]]) {
            return [self cachedFormatters][[NSString stringWithFormat:@"%ld-%ld", (long)dateStyle, (long)timeStyle]];
        } else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:dateStyle];
            [formatter setTimeStyle:timeStyle];
            [formatter setLocale:[NSLocale currentLocale]];
            
            [[self cachedFormatters] setObject:formatter forKey:[NSString stringWithFormat:@"%ld-%ld", (long)dateStyle, (long)timeStyle]];
            return formatter;
        }
    }
}

+ (NSDate *)dateWithDateFormat:(NSString *)dateFormat fromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [self cachedFormatterWithDateFormat:dateFormat];
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle fromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self cachedFormatterWithDateStyle:dateStyle timeStyle:timeStyle];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringWithDateFormat:(NSString *)dateFormat fromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self cachedFormatterWithDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

@end
