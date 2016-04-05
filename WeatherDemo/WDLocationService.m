//
//  WDLocationService.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDLocationService.h"

@interface WDLocationService () <CLLocationManagerDelegate>
@property (strong, nonatomic) RACHotExecutor *localizationHotSignal;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@end

@implementation WDLocationService

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareLocationManager];
        [self prepareLocationHotSignal];
    }
    
    return self;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Signals -
// ----------------------------------------------------------------------------------------------------------------

- (RACSignal *)getCurrentLocation {
    return [[[self.localizationHotSignal.signal ignore:nil] distinctUntilChanged] throttle:0.3f];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Location Manager Delegate -
// ----------------------------------------------------------------------------------------------------------------

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.currentLocation = [locations lastObject];
    [self.localizationHotSignal dataChanged];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Helpers -
// ----------------------------------------------------------------------------------------------------------------

- (void)prepareLocationManager {
    self.locationManager = [CLLocationManager new];
    self.locationManager.distanceFilter = 100.0f;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    self.locationManager.delegate = self;
}

- (void)prepareLocationHotSignal {
    self.localizationHotSignal = [RACHotExecutor executorWithColdExecutor:[self currentLocationExecutor]];
    
    @weakify(self);
    [self.localizationHotSignal setSubscriberCounterBlock:^(NSUInteger observablesCount) {
        @strongify(self);
        if (observablesCount == 1) {
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
        } else if (observablesCount == 0) {
            [self.locationManager stopUpdatingLocation];
        }
    }];
}

- (RACColdExecutor *)currentLocationExecutor {
    @weakify(self);
    return [RACColdExecutor executorWithAsyncBlock:^(RACNotifier *notifier) {
        @strongify(self);
        [notifier sendSuccess:self.currentLocation];
    }];
}

@end
