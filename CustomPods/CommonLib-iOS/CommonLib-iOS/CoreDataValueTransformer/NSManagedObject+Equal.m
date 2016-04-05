//
//  NSManagedObject+Equal.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 19/03/14.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import "NSManagedObject+Equal.h"

@implementation NSManagedObject (Equal)

- (BOOL)MR_isEqual:(id)object {
    if (![object isKindOfClass:[NSManagedObject class]]) {
        return NO;
    }
    
    NSManagedObject *objectToCompare = (NSManagedObject *)object;
    return [[[objectToCompare.objectID URIRepresentation] absoluteString] isEqualToString:[[self.objectID URIRepresentation] absoluteString]];
}

@end
