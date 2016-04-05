//
//  NSUserDefaults+CustomObject.h
//  Bartender
//
//  Created by Grzegorz Sagadyn on 18.10.2013.
//  Copyright (c) 2013 Speednet Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (CustomObject)

- (void)setCustomObject:(id)value forKey:(NSString *)defaultName;
- (id)customObjectForKey:(NSString *)defaultName;

@end
