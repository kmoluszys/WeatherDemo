//
//  RACInternetQueryEngine.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 15.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "RACQueryEngine.h"

@class AFHTTPSessionManager;

@interface RACInternetQueryEngine : RACQueryEngine

/**
 *  `AFHTTPSessionManager` is a subclass of `AFURLSessionManager` with convenience methods for making HTTP requests.
 */
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

/**
 *  An NSMutableURLRequest object represents a mutable URL load request in a manner independent of protocol and URL scheme.
 */
@property (strong, nonatomic) NSMutableURLRequest *mutableUrlRequest;

/*
 * An NSURLSessionDataTask does not provide any additional functionality over an NSURLSessionTask and its presence is merely to provide lexical differentiation from download and upload tasks.
 */
@property (strong, nonatomic) NSURLSessionDataTask *sessionDataTask;

/**
 *  Prepares sessions manager.
 *
 *  @param error Error.
 *
 *  @return Session manager.
 */
- (AFHTTPSessionManager *)prepareSessionManager:(NSError **)error;

/**
 *  Prepares request.
 *
 *  @param error Error.
 *
 *  @return Mutable url request.
 */
- (NSMutableURLRequest *)prepareMutableUrlRequest:(NSError **)error;

/**
 *  Performs request.
 *
 *  @param error Error.
 *
 *  @return Session data task.
 */
- (NSURLSessionDataTask *)prformRequest:(NSError **)error;

/**
 *  Handles response.
 *
 *  @param response       Http response.
 *  @param responseObject Response data.
 *  @param error          Reqyest error.
 */
- (void)handleResponse:(NSURLResponse *)response responseObject:(NSData *)responseObject error:(NSError *)error;

@end
