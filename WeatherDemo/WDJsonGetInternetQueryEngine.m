//
//  WDJsonGetInternetQueryEngine.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDJsonGetInternetQueryEngine.h"
#import "WDEngineResponseParser.h"

static NSInteger const RequestTimeoutInterval = 4.0f;

@implementation WDJsonGetInternetQueryEngine

- (AFHTTPSessionManager *)prepareSessionManager:(NSError **)error {
    AFHTTPSessionManager *sessionManager = [super prepareSessionManager:error];
    sessionManager.requestSerializer.timeoutInterval = RequestTimeoutInterval;
    
    return sessionManager;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Handle response -
// ----------------------------------------------------------------------------------------------------------------

- (void)handleResponse:(NSURLResponse *)response responseObject:(NSData *)responseObject error:(NSError *)error {
    if (error && !responseObject) {
        [self.notifier sendError:error];
        return;
    }
    
    NSError *jsonDeserializationError;
    NSDictionary *jsonDictionary = [WDEngineResponseParser parseResponse:responseObject forQuery:self.query withError:&jsonDeserializationError];
    
    if (jsonDeserializationError) {
        [self.notifier sendError:jsonDeserializationError];
    } else {
        [self.notifier sendSuccess:jsonDictionary];
    }
}

@end
