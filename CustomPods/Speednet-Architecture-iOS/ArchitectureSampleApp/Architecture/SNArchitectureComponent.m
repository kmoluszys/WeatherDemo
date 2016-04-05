//
//  SNArchitectureComponent.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "SNArchitectureComponent.h"

@implementation SNArchitectureComponent

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Mock objects managment
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (NSMutableDictionary *)mockDictionary {
    static NSMutableDictionary *mockDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mockDictionary = [NSMutableDictionary new];
    });
    return mockDictionary;
}

+ (Class)mock {
    @synchronized(self) {
        return [self mockDictionary][NSStringFromClass([self class])];
    }
}

+ (void)setMock:(Class)mock {
    @synchronized(self) {
        [self mockDictionary][NSStringFromClass([self class])] = mock;
    }
}

+ (id)mockObject {
	@synchronized(self) {
		return [self mockDictionary][NSStringFromClass([self class])];
	}
}

+ (void)setMockObject:(id)mockObject {
	@synchronized(self) {
		[self mockDictionary][NSStringFromClass([self class])] = mockObject;
	}
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Create
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (instancetype)create {
	SNArchitectureComponent *classInstance;
	Class classSignature;
	
	if ([[self mockObject] isKindOfClass:[self class]]) {
		classInstance = [self mockObject];
		classSignature = [[self mockObject] class];
	} else {
		classSignature = [self mock] ?: [self class];
		classInstance = [[classSignature alloc] init];
	}
	
	if (classInstance && [classInstance isKindOfClass:[self class]]) {
		return classInstance;
	} else {
		@throw [NSException exceptionWithName:@"Mock class exception" reason:[NSString stringWithFormat:@"Class %@ not inherit by %@", NSStringFromClass(classSignature), NSStringFromClass([self class])] userInfo:nil];
	}
}

@end
