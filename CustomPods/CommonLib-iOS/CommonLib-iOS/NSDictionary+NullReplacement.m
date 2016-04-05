//
//  NSDictionary+NullReplacement.m
//  NavigatorTouch
//
//  Created by Karol Moluszys on 13.02.2014.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import "NSArray+NullReplacement.h"
#import "NSDictionary+NullReplacement.h"

@implementation NSDictionary (NullReplacement)

- (NSDictionary *)dictionaryByRemovingNullValueKeys {
	return [self dictionaryByRemovingNullValueKeysIgnoringArrays:NO];
}

- (NSDictionary *)dictionaryByRemovingNullValueKeysIgnoringArrays:(BOOL)ignoringArrays {
	// First, filter out directly stored nulls
	NSMutableArray *nullKeys = [NSMutableArray array];
	NSMutableArray *arrayKeys = [NSMutableArray array];
	NSMutableArray *dictionaryKeys = [NSMutableArray array];

	NSMutableDictionary *mutableCopy = [self mutableCopy];

	[mutableCopy enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		if (obj == [NSNull null]) {
			[nullKeys addObject:key];
		} else if ([obj isKindOfClass:[NSDictionary class]]) {
			[dictionaryKeys addObject:key];
		} else if ([obj isKindOfClass:[NSArray class]]) {
			[arrayKeys addObject:key];
		}
	}];

	// Remove all the nulls
	[mutableCopy removeObjectsForKeys:nullKeys];

	// Recursively remove nulls from arrays
	for (id arrayKey in arrayKeys) {
		NSMutableArray *array = mutableCopy[arrayKey];
		mutableCopy[arrayKey] = [array arrayByRemovingNullValueKeysIgnoringArrays:ignoringArrays];
	}

	// Cascade down the dictionaries
	for (id dictionaryKey in dictionaryKeys) {
		NSMutableDictionary *dictionary = mutableCopy[dictionaryKey];
		mutableCopy[dictionaryKey] = [dictionary dictionaryByRemovingNullValueKeysIgnoringArrays:ignoringArrays];
	}

	return [mutableCopy copy];
}

@end
