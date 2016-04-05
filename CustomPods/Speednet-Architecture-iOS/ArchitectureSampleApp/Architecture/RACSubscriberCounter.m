//
//  RACSubscriberCounter.m
//  ArchTest
//
//  Created by Konrad Roj on 26.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACSubscriberCounter.h"

@interface RACSubscriberCounter()
@property (readwrite, assign, atomic) NSInteger count;
@end

@implementation RACSubscriberCounter

@synthesize count = _count;

- (id)init {
    self = [super init];
    if (self) {
        self.count = 0;
    }
    return self;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Setter/Getter
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (void)setCount:(NSInteger)newValue {
    @synchronized(self) {
        _count = newValue < 0 ? 0 : newValue;
    }

    if (self.subscriberCounterBlock) {
        self.subscriberCounterBlock(newValue);
    }
}

- (NSInteger)count {
    @synchronized(self) {
        return _count;
    }
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Increment/Decrement
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (void)incrementCount {
    self.count++;
}

- (void)decrementCount {
    self.count--;
}


@end
