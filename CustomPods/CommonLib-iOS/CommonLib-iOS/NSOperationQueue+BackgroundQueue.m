//
//  NSOperationQueue+BackgroundQueue.m
//  FotoKnudsen
//
//  Created by Grzegorz Sagadyn on 23.07.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import "NSOperationQueue+BackgroundQueue.h"

@implementation NSOperationQueue (BackgroundQueue)

+ (NSOperationQueue *)backgroundQueue {
    static NSOperationQueue *_backgroundQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _backgroundQueue = [NSOperationQueue new];
    });
    
    return _backgroundQueue;
}

@end
