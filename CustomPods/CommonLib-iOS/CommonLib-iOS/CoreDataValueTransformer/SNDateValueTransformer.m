//
//  SNDateValueTransformer.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 18/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import "SNDateValueTransformer.h"

@implementation SNDateValueTransformer

+ (Class)transformedValueClass {
    return [NSDate class];
}

@end
