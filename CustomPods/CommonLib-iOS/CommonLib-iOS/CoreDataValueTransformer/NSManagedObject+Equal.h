//
//  NSManagedObject+Equal.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 19/03/14.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Equal)

- (BOOL)MR_isEqual:(id)object;

@end
