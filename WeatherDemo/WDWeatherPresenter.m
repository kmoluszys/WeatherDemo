//
//  WDWeatherPresenter.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDWeatherPresenter.h"
#import "WDWeatherEntity.h"

static NSString * const WDWeatherPresenterDefaultTemp = @"--.-";
static NSString * const WDWeatherPresenterTempSign = @"\u00B0C";
static NSString * const WDWeatherPresenterBackgroundImageNameSunny = @"background_sunny";
static NSString * const WDWeatherPresenterBackgroundImageNameCloudy = @"background_cloudy";
static NSString * const WDWeatherPresenterBackgroundImageNameRainy = @"background_rainy";
static NSString * const WDWeatherPresenterBackgroundImageNameUnknown = @"background_unknown";

@interface WDWeatherPresenter ()
@property (strong, nonatomic) RACDisposable *weatherDisposable;
@property (strong, nonatomic) WDWeatherEntity *weatherEntity;
@end

@implementation WDWeatherPresenter

- (void)startListenToCurrentLocation {
    [self stopListenToCurrentLocation];
    
    @weakify(self);
    self.weatherDisposable = [[self weatherForCurrentLocation] subscribeNext:^(WDWeatherEntity *entity) {
        @strongify(self);
        self.weatherEntity = entity;
    }];
}

- (void)stopListenToCurrentLocation {
    [self.weatherDisposable dispose];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Signals -
// ----------------------------------------------------------------------------------------------------------------

- (RACSignal *)tempForCurrentLocation {
     @weakify(self);
    return [[[[RACObserve(self, weatherEntity) map:^id(WDWeatherEntity *entity) {
        @strongify(self);
        NSString *temp = [self tempFormatter:entity.temp];
        return temp ?: WDWeatherPresenterDefaultTemp;
    }] startWith:WDWeatherPresenterDefaultTemp] map:^id(NSString *temp) {
        return [NSString stringWithFormat:@"%@ %@", temp, WDWeatherPresenterTempSign];
    }] deliverOnMainThread];
}

- (RACSignal *)backgroundImageForCurrentLocation {
    return [[[RACObserve(self, weatherEntity) map:^id(WDWeatherEntity *entity) {
        NSString *imageName;
        switch (entity.type) {
            case WDWeatherTypeSunny:
                imageName = WDWeatherPresenterBackgroundImageNameSunny;
                break;
            case WDWeatherTypeCloudy:
                imageName = WDWeatherPresenterBackgroundImageNameCloudy;
                break;
            case WDWeatherTypeRainy:
                imageName = WDWeatherPresenterBackgroundImageNameRainy;
                break;
            case WDWeatherTypeUnknown:
            default:
                imageName = WDWeatherPresenterBackgroundImageNameUnknown;
                break;
        }
        
        return imageName;
    }] map:^id(NSString *imageName) {
        return [UIImage imageNamed:imageName];
    }] deliverOnMainThread];
}

- (RACSignal *)weatherForCurrentLocation {
    return [[[[WDServiceProvider locationService] getCurrentLocation] flattenMap:^RACStream *(CLLocation *location) {
        return [[[WDServiceProvider weatherService] getWeatherForLocation:location] catch:^RACSignal *(NSError *error) {
            return [RACSignal return:nil];
        }];
    }] deliverOnMainThread];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Helpers -
// ----------------------------------------------------------------------------------------------------------------

- (NSString *)tempFormatter:(NSNumber *)temp {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMinimumFractionDigits:1];
    [numberFormatter setMinimumFractionDigits:1];
    
    return [numberFormatter stringFromNumber:temp];
}

@end
