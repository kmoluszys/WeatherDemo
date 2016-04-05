//
//  WDWeatherViewController.m
//  WeatherDemo
//
//  Created by Grzegorz Sagadyn on 05.04.2016.
//  Copyright © 2016 Speednet Sp. z o.o. All rights reserved.
//

#import "WDWeatherViewController.h"

@interface WDWeatherViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@property (strong, nonatomic) WDWeatherPresenter *presenter;
@end

@implementation WDWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [WDPresenterProvider weatherPresenter];
    
    RAC(self.tempLabel, text) = [self.presenter tempForCurrentLocation];
    RAC(self.backgroundImageView, image) = [self.presenter backgroundImageForCurrentLocation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.presenter startListenToCurrentLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.presenter stopListenToCurrentLocation];
}

@end
