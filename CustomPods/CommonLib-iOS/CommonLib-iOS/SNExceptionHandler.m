//
//  ExceptionHandler.m
//  SNLog
//
//  Created by Grzegorz Sagadyn on 09.08.2013.
//  Copyright (c) 2013 Speednet Sp. z o.o. All rights reserved.
//

#import "SNExceptionHandler.h"
#include <assert.h>
#include <stdbool.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>

#define EXCEPTION_KEY @"ExceptionHandlerKey"
#define EXCEPTION_TO_SEND_KEY @"ExceptionToSendHandlerKey"

BOOL ApplicationBeingDebugged(void) {
    int                 junk;
    int                 mib[4];
    struct kinfo_proc   info;
    size_t              size;
    
    // Initialize the flags so that, if sysctl fails for some bizarre
    // reason, we get a predictable result.
    
    info.kp_proc.p_flag = 0;
    
    // Initialize mib, which tells sysctl the info we want, in this case
    // we're looking for information about a specific process ID.
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();
    
    // Call sysctl.
    
    size = sizeof(info);
    junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    assert(junk == 0);
    
    // We're being debugged if the P_TRACED flag is set.
    
    return ( (info.kp_proc.p_flag & P_TRACED) != 0 );
}


@implementation SNExceptionHandler

static SNExceptionHandler *sharedInstance;

+ (SNExceptionHandler *)sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[SNExceptionHandler alloc] init];
    }
    
    return sharedInstance;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Main exception handler
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------
- (int)handleExceptionInBlock:(int (^)())block withSend:(BOOL)sendFlag {
    if (sendFlag) {
        [self sendExceptions];
    }
    
    int result = 0;
    
    if (ApplicationBeingDebugged()) {
        result = block();
    } else {
        @try {
            result = block();
        }
        @catch (NSException *exception) {
            NSLog(@"Exception: %@", exception.debugDescription);
            [self addException:exception];
            result = 1;
        }
    }
    
    return result;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark SEND METHODS
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (void)sendExceptions {
    if ([self wasAnyExceptionAtKey:EXCEPTION_KEY] || [self wasAnyExceptionAtKey:EXCEPTION_TO_SEND_KEY]) {
        NSString *exString = [self getExceptionsAtKey:EXCEPTION_TO_SEND_KEY];
        exString = exString.length < 5 ? @"|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n" : exString;
        exString = [exString stringByAppendingString:[self getExceptionsAtKey:EXCEPTION_KEY]];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:exString forKey:EXCEPTION_TO_SEND_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self removeExceptionsAtKey:EXCEPTION_KEY];
        
        [self performSelectorInBackground:@selector(connectionInit) withObject:nil];
    }
}

- (void)connectionInit {
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    NSString *exString = [self getExceptionsAtKey:EXCEPTION_TO_SEND_KEY];
    
    NSURL *requestUrl = [NSURL URLWithString:SERVER_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[[NSString stringWithFormat:SERVER_URL_BODY, prodName, exString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
    }];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self removeExceptionsAtKey:EXCEPTION_TO_SEND_KEY];
    NSLog(@"Exceptions sent");
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Helper methods
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (NSString *)currentTime {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat stringFromDate:[NSDate date]];
}

- (NSString *)deviceInfo {
    NSString *iOSVersion = [UIDevice currentDevice].systemVersion;
    NSString *deviceModel = [UIDevice currentDevice].model;
    
    return [NSString stringWithFormat:@"%@ iOS: %@", deviceModel, iOSVersion];
}

- (NSString *)appInfo {
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    
    return [NSString stringWithFormat:@"%@ ver. %@", prodName, appVersion];
}

- (NSString *)getExceptionsAtKey:(NSString *)key {
    NSString *exception = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return exception.length > 5 ? exception : @"";
}

- (void)removeExceptionsAtKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)wasAnyExceptionAtKey:(NSString *)key {
    NSString *exString = [self getExceptionsAtKey:key];
    return (exString && ![exString isEqualToString:@""]);
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Exception logger
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (void)addException:(NSException *)exception {
    @synchronized(self) {
        NSString *exString = [self getExceptionsAtKey:EXCEPTION_KEY];
        
        NSMutableString *mutableString = [[NSMutableString alloc] initWithCapacity:0];
        [mutableString appendFormat:@"==================[ %@ ]==================\n", [self currentTime]];
        [mutableString appendFormat:@"Device info: %@\n", [self deviceInfo]];
        [mutableString appendFormat:@"App info: %@\n", [self appInfo]];
        [mutableString appendFormat:@"Level: %@\n", @"Exception"];
        [mutableString appendFormat:@"Exception name: %@\n", [exception name]];
        [mutableString appendFormat:@"Exception reason: %@\n", [exception reason]];
        [mutableString appendFormat:@"Call stack symbols: \n%@\n", [exception callStackSymbols]];
        [mutableString appendFormat:@"===========================================================\n\n"];
        
        exString = [exString stringByAppendingString:mutableString];
        [[NSUserDefaults standardUserDefaults] setObject:exString forKey:EXCEPTION_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
