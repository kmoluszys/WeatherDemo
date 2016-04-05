//
//  RACInternetQuery.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 15.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACQuery.h"

@interface RACInternetQuery : RACQuery
/**
 *  Server url.
 */
@property (readonly, strong, nonatomic) NSString *serverUrl;

@end
