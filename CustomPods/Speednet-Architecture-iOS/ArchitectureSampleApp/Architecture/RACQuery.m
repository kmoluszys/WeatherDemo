//
//  SNQuery.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 09.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACQuery.h"
#import "objc/runtime.h"

@implementation RACQuery

- (NSDictionary *)queryContent {
    NSArray *propertiesNames = [RACQuery propertiesNamesForClass:[self class]];

    NSMutableDictionary *params = [NSMutableDictionary new];
    NSDictionary *mapDictionary = [self mapKeys];

    for (NSString *key in propertiesNames) {
        id value = [self valueForKey:key];

        if (!value) {
            continue;
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            [params setValuesForKeysWithDictionary:value];
            continue;
		} else if ([value isKindOfClass:[NSNumber class]]) {
			[params setObject:value forKey:key];
		} else if (![value isKindOfClass:[NSString class]]) {
            @throw [NSException exceptionWithName:@"Query composer exception" reason:[NSString stringWithFormat:@"Property with name %@ is not NSString", key] userInfo:nil];
        }

        NSString *mappedKey = key;
        if ([mapDictionary.allKeys containsObject:key]) {
            mappedKey = mapDictionary[key];
        }

        [params setObject:value forKey:mappedKey];
    }

    return [NSDictionary dictionaryWithDictionary:params];
}

- (NSDictionary *)mapKeys {
    return @{};
}

- (NSString *)description {
    return self.queryContent.description;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Properties names
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (NSArray *)propertiesNamesForClass:(Class)classDef {
    if (classDef == NULL) {
        return nil;
    }

    NSMutableArray *results = [[NSMutableArray alloc] init];

    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(classDef, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];

            if ([propertyName isEqualToString:@"requestContent"] || [propertyName isEqualToString:@"encoding"] || [propertyName hasPrefix:@"__"]) {
                continue;
            }

            [results addObject:propertyName];
        }
    }
    free(properties);

    return [NSArray arrayWithArray:results];
}

@end
