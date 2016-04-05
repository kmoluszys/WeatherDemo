//
//  NSDateFormatter+Cache.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 17/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Cache)
+ (NSDateFormatter *)cachedFormatterWithDateFormat:(NSString *)dateFormat;
+ (NSDate *)dateWithDateFormat:(NSString *)dateFormat fromString:(NSString *)dateString;
+ (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle fromDate:(NSDate *)date;
+ (NSString *)stringWithDateFormat:(NSString *)dateFormat fromDate:(NSDate *)date;
@end
