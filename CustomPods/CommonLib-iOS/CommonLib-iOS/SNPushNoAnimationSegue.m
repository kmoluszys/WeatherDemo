//
//  SNPushNoAnimationSegue.m
//  NavigatorTouch
//
//  Created by Karol Moluszys on 30.01.2014.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import "SNPushNoAnimationSegue.h"

@implementation SNPushNoAnimationSegue

- (void) perform {
    [[self.sourceViewController navigationController] pushViewController:self.destinationViewController animated:NO];
}

@end
