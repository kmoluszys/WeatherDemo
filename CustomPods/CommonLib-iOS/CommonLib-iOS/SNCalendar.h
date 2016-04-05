//
//  SNCalendar.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 07/02/14.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EKCalendar;

@interface SNCalendar : NSObject

+ (void)requestAccess:(void (^)(BOOL granted, NSError *error))success;

+ (EKCalendar *)calendarWithTitle:(NSString *)title;
+ (NSArray *)avaibleCalendars;

+ (NSString *)addEventWithTitle:(NSString *)title calendarIdentifier:(NSString *)calendarIdentifier startDate:(NSDate *)startDate alarm:(NSDate *)alarm;
+ (NSString *)addEventWithTitle:(NSString *)title calendarIdentifier:(NSString *)calendarIdentifier startDate:(NSDate *)startDate endDate:(NSDate *)endDate allDay:(BOOL)allDay alarm:(NSDate *)alarm alarmTimeBefore:(NSTimeInterval)alarmTime;
+ (BOOL)removeEventWithId:(NSString *)eventId;

@end
