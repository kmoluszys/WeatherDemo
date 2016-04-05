//
//  NSObject+Reflection.h
//  NavigatorTouch
//
//  Created by Karol Moluszys on 11/19/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Reflection)
- (void)setReflectionValue:(id)value forKey:(NSString *)key;
- (NSString *)containsProperty:(NSString *)propertyKey;
@end
