//
//  ExceptionHandler.h
//  zglaszaiebledow
//
//  Created by Grzegorz Sagadyn on 20.12.2012.
//  Copyright (c) 2012 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_URL @"http://mkaminski.a.park.dev.speednet.pl/logger.php"
#define SERVER_URL_BODY @"key=753951&app_name=%@&log=%@"

@interface SNExceptionHandler : NSObject

+ (SNExceptionHandler *)sharedInstance;
- (int)handleExceptionInBlock:(int (^)())block withSend:(BOOL)sendFlag;
- (void)addException:(NSException *)exception;
- (void)sendExceptions;

@end
