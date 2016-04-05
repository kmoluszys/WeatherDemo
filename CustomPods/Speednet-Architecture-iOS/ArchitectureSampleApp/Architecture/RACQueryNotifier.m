//
//  RACQueryNotifier.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACQueryNotifier.h"
#import "RACQuery.h"

@implementation RACQueryNotifier

- (void)sendNext:(RACQuery *)nextObject {
    if (![nextObject isKindOfClass:[RACQuery class]]) {
        @throw [NSException exceptionWithName:@"RACQueryNotifier - Cast error" reason:@"sendNext: method requires RACQuery argument" userInfo:nil];
    }

    [super sendNext:nextObject];
}

- (void)sendSuccess:(RACQuery *)successObject {
    if (![successObject isKindOfClass:[RACQuery class]]) {
        @throw [NSException exceptionWithName:@"RACQueryNotifier - Cast error" reason:@"sendSuccess: method requires RACQuery argument" userInfo:nil];
    }

    [super sendSuccess:successObject];
}

@end
