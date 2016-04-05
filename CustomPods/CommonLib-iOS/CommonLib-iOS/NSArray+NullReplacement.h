//
//  NSArray+NullReplacement.h
//  NavigatorTouch
//
//  Created by Karol Moluszys on 13.02.2014.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NullReplacement)
- (NSArray *)arrayByRemovingNullValueKeys;
- (NSArray *)arrayByRemovingNullValueKeysIgnoringArrays:(BOOL)ignoringArrays;
@end
