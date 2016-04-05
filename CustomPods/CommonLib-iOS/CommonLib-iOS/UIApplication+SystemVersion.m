//
//  UIApplication+SystemVersion.m
//  BPH
//
//  Created by Grzegorz Sagadyn on 17.10.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import "UIApplication+SystemVersion.h"

@implementation UIApplication (SystemVersion)

+ (BOOL)systemVersionIsEqualTo:(NSString *)systemVersion {
	return [[[UIDevice currentDevice] systemVersion] compare:systemVersion options:NSNumericSearch] == NSOrderedSame;
}

+ (BOOL)systemVersionIsGreaterThan:(NSString *)systemVersion {
	return [[[UIDevice currentDevice] systemVersion] compare:systemVersion options:NSNumericSearch] == NSOrderedDescending;
}

+ (BOOL)systemVersionIsGreaterThanOrEqualTo:(NSString *)systemVersion {
	return [[[UIDevice currentDevice] systemVersion] compare:systemVersion options:NSNumericSearch] != NSOrderedAscending;
}

+ (BOOL)systemVersionIsLessThan:(NSString *)systemVersion {
	return [[[UIDevice currentDevice] systemVersion] compare:systemVersion options:NSNumericSearch] == NSOrderedAscending;
}

+ (BOOL)systemVersionIsLessThanOrEqualTo:(NSString *)systemVersion {
	return [[[UIDevice currentDevice] systemVersion] compare:systemVersion options:NSNumericSearch] != NSOrderedDescending;
}

@end
