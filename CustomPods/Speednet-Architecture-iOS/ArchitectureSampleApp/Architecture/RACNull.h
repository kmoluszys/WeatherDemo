//
//  RACNull.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 08.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Reactive null value.
 */
@interface RACNull : NSObject

- (instancetype)init DEPRECATED_MSG_ATTRIBUTE("Use null method");
+ (instancetype)new DEPRECATED_MSG_ATTRIBUTE("Use null method");

/**
 *  Returns object representing null value.
 *
 *  @return RACNull instance.
 */
+ (instancetype)null;

@end
