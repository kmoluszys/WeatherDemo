//
//  SNArchitectureComponent.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNArchitectureComponent : NSObject

+ (Class)mock;
+ (void)setMock:(Class)mock;
+ (id)mockObject;
+ (void)setMockObject:(id)mockObject;

+ (instancetype)create;

@end
