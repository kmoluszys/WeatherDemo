//
//  NSObject+Reflection.m
//  NavigatorTouch
//
//  Created by Karol Moluszys on 11/19/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import "NSObject+Reflection.h"
#import <objc/runtime.h>

//#define SHOW_LOG

#ifdef SHOW_LOG
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
    #define NSLog(...)
#endif

@implementation NSObject (Reflection)

- (void)setReflectionValue:(id)value forKey:(NSString *)key {
    objc_property_t property = class_getProperty(self.class, [key cStringUsingEncoding:NSASCIIStringEncoding]);
    const char * const attrString = property_getAttributes(property);
    NSString *attr = [NSString stringWithUTF8String:attrString];
    NSArray *array = [attr componentsSeparatedByString:@"\""];
    
    @try {
        if ([value isKindOfClass:NSClassFromString(array[1])]) {
            [self setValue:value forKey:key];
        } else {
            NSLog(@"Mismatched type of variable (%@ != %@) at class: %@", array[1], [value class], [self class]);
        }
    }
    @catch (NSException *exception) {
        @try {
            [self setValue:value forKey:key];
            NSLog(@"Warning while checking the type of the variable \"%@\" (setValue %@ = %@) at class: \"%@\"", key, [value class], value, [self class]);
        }
        @catch (NSException *exception) {
            NSLog(@"Error setValue:(%@ %@) forKey:%@", [value class], value, key);
        }
    }
}

- (NSString *)containsProperty:(NSString *)propertyKey {
    if ([self respondsToSelector:NSSelectorFromString(propertyKey)]) {
        return propertyKey;
    }
    
    return nil;
}

@end
