//
//  NSOperationQueue+BackgroundQueue.h
//  FotoKnudsen
//
//  Created by Grzegorz Sagadyn on 23.07.2014.
//  Copyright (c) 2014 Speednet Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (BackgroundQueue)

+ (NSOperationQueue *)backgroundQueue;

@end
