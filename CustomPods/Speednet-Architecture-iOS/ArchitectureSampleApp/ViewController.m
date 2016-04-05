//
//  ViewController.m
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 08.04.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import "ViewController.h"
#import "RACTestQuery.h"

@interface ViewController ()
@property (strong, nonatomic) RACQueryExecutor *test;
//@property (strong, nonatomic) RACDisposable *dis;
//@property (strong, nonatomic) RACSignal *sig;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RACCache *testCache = [RACCache new];
    
    RACQueryExecutor *test1 = [RACQueryExecutor executorWithEngine:[RACGetInternetQueryEngine new] queryBlock:^(RACQueryNotifier *notifier) {        
        [notifier sendNext:[RACTestQuery new]];
        
        [notifier sendNext:[RACTestQuery new]];
                
        [notifier sendSuccess:[RACTestQuery new]];
    }];

    [[[test1.signal deliverOnMainThread] saveToCache:testCache forKey:@"testCacheKey"] subscribeNext:^(id x) {
        NSLog(@">>>>>>> %@", x);
    } error:^(NSError *error) {
        NSLog(@">>>>>>> %@", error);
    } completed:^{
        NSLog(@"completed");
        
        [[RACSignal cache:testCache objectForKey:@"testCacheKey"] subscribeNext:^(id x) {
            NSLog(@">>>>>>> %@", x);
        }];
    }];

    
    
    
    
//    self.sig = [RACQueryExecutor executorWithEngine:[RACGetInternetQueryEngine new] queryBlock:^(RACQueryNotifier *notifier) {
//        [NSTimer scheduledTimerInRunLoop:[NSRunLoop mainRunLoop] withTimeInterval:10.0f block:^(NSTimer *timer) {
//            [notifier sendSuccess:[RACTestQuery new]];
//        } repeats:NO];
//    }].signal;
//
//
//    [[self.sig  deliverOnMainThread] subscribeNext:^(id x) {
//        NSLog(@"!>>>>>>> %@", x);
//    } error:^(NSError *error) {
//        NSLog(@"!>>>>>>> %@", error);
//    } completed:^{
//        NSLog(@"!completed");
//    }];


    //    [[[RACQueryExecutor executorWithEngine:[RACGetInternetQueryEngine new] queryBlock:^(RACQueryNotifier *notifier) {
    //        [NSTimer scheduledTimerInRunLoop:[NSRunLoop mainRunLoop] withTimeInterval:1.0f block:^(NSTimer *timer) {
    ////            [notifier sendSuccess:[RACTestQuery new]];
    //        } repeats:NO];
    //    }].signal deliverOnMainThread] subscribeNext:^(id x) {
    //        NSLog(@">>>>>>> %@", x);
    //    } error:^(NSError *error) {
    //        NSLog(@">>>>>>> %@", error);
    //    } completed:^{
    //        NSLog(@"completed");
    //    }];

//    [disposable dispose];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Test
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

//- (void)hotNextError {
//    __block NSInteger count = 0;
//    RACColdExecutor *test = [RACColdExecutor executorWithSyncBlock:^id(NSError *__autoreleasing *error) {
//        return @"test";
//    }];
//
//    RACHotExecutor *executor = [RACHotExecutor executorWithColdExecutor:test];
//
//    [[executor.signal omitErrorByValue:@"test error"] subscribeNext:^(id x) {
//        NSLog(@"next: %@", x);
//    } error:^(NSError *error) {
//        NSLog(@"error: %@", error);
//    } completed:^{
//        NSLog(@"completed");
//    }];
//
//    [NSTimer scheduledTimerWithTimeInterval:1.0f block:^(NSTimer *timer) {
//        if (count < 4) {
//            [executor dataChanged];
//        } else {
//            [executor.behaviorSubject sendError:[NSError errorWithDomain:@"test" code:1 userInfo:nil]];
//            [timer invalidate];
//        }
//        count++;
//    } repeats:YES];
//}
//
//- (void)hotNextCompleted {
//    __block NSInteger count = 0;
//    RACColdExecutor *test = [RACColdExecutor executorWithSyncBlock:^id(NSError *__autoreleasing *error) {
//        return @"test";
//    }];
//
//    RACHotExecutor *executor = [RACHotExecutor executorWithColdExecutor:test];
//
//    [executor.signal subscribeNext:^(id x) {
//        NSLog(@"next: %@", x);
//    } error:^(NSError *error) {
//        NSLog(@"error: %@", error);
//    } completed:^{
//        NSLog(@"completed");
//    }];
//
//    [NSTimer scheduledTimerWithTimeInterval:1.0f block:^(NSTimer *timer) {
//        if (count < 4) {
//            [executor dataChanged];
//        } else {
//            [executor.behaviorSubject sendCompleted];
//            [timer invalidate];
//        }
//        count++;
//    } repeats:YES];
//}
//
//- (void)coldAsyncNext {
//    self.testExecutor = [RACColdExecutor executorWithAsyncBlock:^(RACNotifier *notifier) {
//        [NSTimer scheduledTimerInRunLoop:[NSRunLoop mainRunLoop] withTimeInterval:2.0f block:^(NSTimer *timer) {
//            [notifier sendSuccess:@"test"];
//        } repeats:NO];
//    }];
//
//    [self.testExecutor.signal subscribeNext:^(id x) {
//        NSLog(@"next: %@", x);
//    } error:^(NSError *error) {
//        NSLog(@"error: %@", error);
//    } completed:^{
//        NSLog(@"completed");
//    }];
//}
//
//- (void)coldSyncError {
//    RACColdExecutor *test = [RACColdExecutor executorWithSyncBlock:^id(NSError *__autoreleasing *error) {
//        *error = [NSError errorWithDomain:@"test" code:1 userInfo:nil];
//        return nil;
//    }];
//
//    [test.signal subscribeNext:^(id x) {
//        NSLog(@"next: %@", x);
//    } error:^(NSError *error) {
//        NSLog(@"error: %@", error);
//    } completed:^{
//        NSLog(@"completed");
//    }];
//}
//
//- (void)coldSyncNext {
//    RACColdExecutor *test = [RACColdExecutor executorWithSyncBlock:^id(NSError *__autoreleasing *error) {
//        return @"test";
//    }];
//
//    [test.signal subscribeNext:^(id x) {
//        NSLog(@"next: %@", x);
//    } error:^(NSError *error) {
//        NSLog(@"error: %@", error);
//    } completed:^{
//        NSLog(@"completed");
//    }];
//}

@end
