//
//  NSNumberFormatter+Cache.h
//  NavigatorTouch
//
//  Created by Karol Moluszys on 07.01.2014.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (Cache)

+ (NSNumberFormatter *)cachedFormatterWithNumberStyle:(NSNumberFormatterStyle)style;
+ (NSNumber *)numberWithNumberStyle:(NSNumberFormatterStyle)style fromString:(NSString *)numberString;

@end
