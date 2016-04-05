//
//  RACInternetQueryEngine.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 15.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACInternetQueryEngine.h"
#import <AFNetworking/AFNetworking.h>
#import <SDNetworkActivityIndicator/SDNetworkActivityIndicator.h>
#import "RACNotifier.h"
#import "RACInternetQuery.h"

@interface RACInternetQueryEngine ()
@end

@implementation RACInternetQueryEngine

- (void)start {
    if (![self.query isKindOfClass:[RACInternetQuery class]]) {
        @throw [NSException exceptionWithName:@"RACInternetQueryEngine - class cast exception" reason:[NSString stringWithFormat:@"Query \"%@\" is not kind of RACInternetQuery class", NSStringFromClass([self.query class])] userInfo:nil];
    }

    [[SDNetworkActivityIndicator sharedActivityIndicator] startActivity];

    NSError *error;

    self.sessionManager = [self prepareSessionManager:&error];
    if (error) {
        [self.notifier sendError:error];
        return;
    }

    self.mutableUrlRequest = [self prepareMutableUrlRequest:&error];
    if (error) {
        [self.notifier sendError:error];
        return;
    }

    self.sessionDataTask = [self prformRequest:&error];
    if (error) {
        [self.notifier sendError:error];
        return;
    }
}

- (AFHTTPSessionManager *)prepareSessionManager:(NSError **)error {
    RACInternetQuery *internetQuery = (RACInternetQuery *)self.query;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:internetQuery.serverUrl] sessionConfiguration:configuration];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];

    return sessionManager;
}

- (NSMutableURLRequest *)prepareMutableUrlRequest:(NSError **)error {
    @throw [NSException exceptionWithName:@"RACInternetQueryEngine - abstract method exception" reason:[NSString stringWithFormat:@"Class \"%@\" not implement abstract method \"prepareMutableUrlRequest\"", NSStringFromClass([self class])] userInfo:nil];
}

- (NSURLSessionDataTask *)prformRequest:(NSError **)error {
    NSURLSessionDataTask *sessionDataTask = [self.sessionManager dataTaskWithRequest:self.mutableUrlRequest completionHandler:^(NSURLResponse * __unused response, NSData *responseObject, NSError *error) {
        [[SDNetworkActivityIndicator sharedActivityIndicator] stopActivity];

        [self handleResponse:response responseObject:responseObject error:error];
    }];

    [sessionDataTask resume];

    return sessionDataTask;
}

- (void)handleResponse:(NSURLResponse *)response responseObject:(NSData *)responseObject error:(NSError *)error {
    @throw [NSException exceptionWithName:@"RACInternetQueryEngine - abstract method exception" reason:[NSString stringWithFormat:@"Class \"%@\" not implement abstract method \"handleResponse:responseObject:error:\"", NSStringFromClass([self class])] userInfo:nil];
}

- (void)cancel {
    [[SDNetworkActivityIndicator sharedActivityIndicator] stopActivity];
    [self.sessionDataTask cancel];
}

@end
