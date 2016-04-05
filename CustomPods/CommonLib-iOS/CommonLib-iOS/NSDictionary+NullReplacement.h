//
//  NSDictionary+NullReplacement.h
//  NavigatorTouch
//
//  Created by Karol Moluszys on 13.02.2014.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplacement)
- (NSDictionary *)dictionaryByRemovingNullValueKeys;
- (NSDictionary *)dictionaryByRemovingNullValueKeysIgnoringArrays:(BOOL)ignoringArrays;
@end
