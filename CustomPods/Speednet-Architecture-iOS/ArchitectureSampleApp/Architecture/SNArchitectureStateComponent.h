//
//  SNArchitectureStateComponent.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "SNArchitectureComponent.h"

typedef enum : NSUInteger {
    SNArchitectureStateComponentScopedType,
    SNArchitectureStateComponentPermanentType,
} SNArchitectureStateComponentType;

@interface SNArchitectureStateComponent : SNArchitectureComponent

/**
 *  Creates instance of architecture state component
 *
 *  @param type Component type
 *
 *  @return Instance of architecture component
 */
+ (instancetype)createWithType:(SNArchitectureStateComponentType)type;

/**
 *  Deletes permanent architecture component
 */
+ (void)deletePermanentInstance;

@end
