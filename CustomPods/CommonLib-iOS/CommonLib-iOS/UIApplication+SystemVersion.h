//
//  UIApplication+SystemVersion.h
//  BPH
//
//  Created by Grzegorz Sagadyn on 17.10.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (SystemVersion)

+ (BOOL)systemVersionIsEqualTo:(NSString *)systemVersion;
+ (BOOL)systemVersionIsGreaterThan:(NSString *)systemVersion;
+ (BOOL)systemVersionIsGreaterThanOrEqualTo:(NSString *)systemVersion;
+ (BOOL)systemVersionIsLessThan:(NSString *)systemVersion;
+ (BOOL)systemVersionIsLessThanOrEqualTo:(NSString *)systemVersion;

@end
