//
//  SNQuery.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 09.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACQuery : NSObject
/**
 *  Query content.
 */
@property (readonly, strong, nonatomic) NSDictionary *queryContent;

/**
 *  Map keys {from : to}
 *
 *  @return Dictionary with mapped keys
 */
- (NSDictionary *)mapKeys;

/**
 *  Gets list of the properties names
 *
 *  @param classDef Class type
 *
 *  @return Properties names
 */
+ (NSArray *)propertiesNamesForClass:(Class)classDef;

@end
