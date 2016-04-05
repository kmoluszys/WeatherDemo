//
//  NSArray+Tools.m
//  FotoKnudsen
//
//  Created by Grzegorz Sagadyn on 17.07.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import "NSArray+Tools.h"

@implementation NSArray (Tools)

- (BOOL)isEmpty {
	return self.firstObject ? NO : YES;
}

@end
