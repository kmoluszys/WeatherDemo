//
//  NSUserDefaults+CustomObject.m
//  Bartender
//
//  Created by Grzegorz Sagadyn on 18.10.2013.
//  Copyright (c) 2013 Speednet Sp. z o.o. All rights reserved.
//

#import "NSUserDefaults+CustomObject.h"

@implementation NSUserDefaults (CustomObject)

- (void)setCustomObject:(id)value forKey:(NSString *)defaultName {
    NSData *objectData = [NSKeyedArchiver archivedDataWithRootObject:value];
    [self setObject:objectData forKey:defaultName];
}

- (id)customObjectForKey:(NSString *)defaultName {
    NSData *objectData = [self objectForKey:defaultName];
    
    id userObject;
    if(objectData != nil) {
        userObject = [NSKeyedUnarchiver unarchiveObjectWithData:objectData];
    }
    
    return userObject;
}

@end
