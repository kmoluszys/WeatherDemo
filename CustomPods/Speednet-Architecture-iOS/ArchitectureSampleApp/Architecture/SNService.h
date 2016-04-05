//
//  SNService.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "SNArchitectureStateComponent.h"

@class RACCache;

@interface SNService : SNArchitectureStateComponent
@property (readonly, strong, nonatomic) RACCache *globalCache;
@property (readonly, strong, nonatomic) RACCache *localCache;

@end
