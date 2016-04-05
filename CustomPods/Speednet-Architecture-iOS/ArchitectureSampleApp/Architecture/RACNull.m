//
//  RACNull.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 08.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACNull.h"

@implementation RACNull

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)new {
    return [super new];
}

+ (instancetype)null {
    static RACNull *sharedNull = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNull = [[[self class] alloc] init];
    });
    return sharedNull;
}

@end
