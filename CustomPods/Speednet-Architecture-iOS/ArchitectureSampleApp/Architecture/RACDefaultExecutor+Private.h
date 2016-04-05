//
//  RACDefaultExecutor+Private.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 13.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACExecutor+Private.h"

@interface RACDefaultExecutor ()
@property (copy, nonatomic) RACSyncExecutorBlock syncExecutorBlock;
@property (copy, nonatomic) RACAsyncExecutorBlock asyncExecutorBlock;

@end
