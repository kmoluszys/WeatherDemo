//
//  SNArchitectureStateComponent.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "SNArchitectureStateComponent.h"

@implementation SNArchitectureStateComponent

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Permanent objects managment
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (NSMutableDictionary *)permanenObjectsDictionary {
    static NSMutableDictionary *permanenObjectsDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        permanenObjectsDictionary = [NSMutableDictionary new];
    });
    return permanenObjectsDictionary;
}

+ (SNArchitectureStateComponent *)component {
    @synchronized(self) {
        return [self permanenObjectsDictionary][NSStringFromClass([self class])];
    }
}

+ (void)setComponent:(SNArchitectureStateComponent *)component {
    @synchronized(self) {
        [self permanenObjectsDictionary][NSStringFromClass([self class])] = component;
    }
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Create / remove
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (instancetype)createWithType:(SNArchitectureStateComponentType)type {
    SNArchitectureStateComponent *component;

    if (type == SNArchitectureStateComponentScopedType) {
        component = [self create];
    } else if (!(component = [self component])) {
        component = [self create];
        [self setComponent:component];
    }

    return component;
}

+ (void)deletePermanentInstance {
    @synchronized(self) {
        [[self permanenObjectsDictionary] removeObjectForKey:NSStringFromClass([self class])];
    }
}

@end
