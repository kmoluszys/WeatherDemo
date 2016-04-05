//
//  RACPostInternetQueryEngine.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 15.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACPostInternetQueryEngine.h"
#import <AFNetworking/AFNetworking.h>
#import "RACNotifier.h"
#import "RACInternetQuery.h"
#import "NSString+Tools.h"

@implementation RACPostInternetQueryEngine

- (NSMutableURLRequest *)prepareMutableUrlRequest:(NSError *__autoreleasing *)error {
    RACInternetQuery *internetQuery = (RACInternetQuery *)self.query;
    NSDictionary *parameters = internetQuery.queryContent;
    parameters = parameters.count > 0 ? parameters : nil;

    return [self.sessionManager.requestSerializer requestWithMethod:@"POST" URLString:internetQuery.serverUrl parameters:parameters error:nil];
}

- (void)handleResponse:(NSURLResponse *)response responseObject:(NSData *)responseObject error:(NSError *)error {
    if (error) {
        [self.notifier sendError:error];
        return;
    }

    [self.notifier sendSuccess:[NSString getStringFromData:responseObject]];
}

@end
