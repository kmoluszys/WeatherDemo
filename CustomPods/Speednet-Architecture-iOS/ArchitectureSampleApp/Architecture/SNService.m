//
//  SNService.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "SNService.h"
#import "RACCache.h"

@interface SNService ()
@property (readwrite, strong, nonatomic) RACCache *localCache;
@property (nonatomic, assign) dispatch_once_t onceToken;
@end

@implementation SNService

- (RACCache *)globalCache {
    return [RACCache sharedCache];
}

- (RACCache *)localCache {
    dispatch_once(&_onceToken, ^{
        _localCache = [RACCache new];
    });
    
    return _localCache;
}

@end
