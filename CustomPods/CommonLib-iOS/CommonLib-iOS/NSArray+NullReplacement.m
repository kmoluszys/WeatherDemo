//
//  NSArray+NullReplacement.m
//  NavigatorTouch
//
//  Created by Karol Moluszys on 13.02.2014.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import "NSArray+NullReplacement.h"
#import "NSDictionary+NullReplacement.h"

@implementation NSArray (NullReplacement)

- (NSArray *)arrayByRemovingNullValueKeys {
	return [self arrayByRemovingNullValueKeysIgnoringArrays:NO];
}

- (NSArray *)arrayByRemovingNullValueKeysIgnoringArrays:(BOOL)ignoringArrays {
	// First, filter out directly stored nulls if required
	NSMutableArray *mutableCopy = [self mutableCopy];
	if (!ignoringArrays) {
		[mutableCopy filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
						 return evaluatedObject != [NSNull null];
					 }]];
	}

	NSMutableIndexSet *arrayIndexes = [NSMutableIndexSet indexSet];
	NSMutableIndexSet *dictionaryIndexes = [NSMutableIndexSet indexSet];

	[mutableCopy enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		if ([obj isKindOfClass:[NSDictionary class]]) {
			[dictionaryIndexes addIndex:idx];
		} else if ([obj isKindOfClass:[NSArray class]]) {
			[arrayIndexes addIndex:idx];
		}
	}];

	// Recursively remove nulls from arrays
	for (NSArray *containedArray in [mutableCopy objectsAtIndexes:arrayIndexes]) {
		NSUInteger index = [mutableCopy indexOfObject:containedArray];
		mutableCopy[index] = [containedArray arrayByRemovingNullValueKeysIgnoringArrays:ignoringArrays];
	}

	// Cascade down the dictionaries
	for (NSDictionary *containedDictionary in [mutableCopy objectsAtIndexes:dictionaryIndexes]) {
		NSUInteger index = [mutableCopy indexOfObject:containedDictionary];
		mutableCopy[index] = [containedDictionary dictionaryByRemovingNullValueKeysIgnoringArrays:ignoringArrays];
	}

	return [mutableCopy copy];
}

@end
