//
//  SNCalendar.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 07/02/14.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import "SNCalendar.h"
#import <EventKit/EventKit.h>

#define kCALENDAR_IDENTIFIER @"calendar_identifier"

@implementation SNCalendar
static EKEventStore *eventStore = nil;

+ (void)requestAccess:(void (^)(BOOL granted, NSError *error))callback; {
    if (eventStore == nil) {
        eventStore = [[EKEventStore alloc] init];
    }
    // request permissions
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:callback];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Getters
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (NSArray *)avaibleCalendars {
    NSArray *calendars = [eventStore calendarsForEntityType:EKEntityTypeEvent];
    NSMutableArray *writableCalendars = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (EKCalendar *calendar in calendars) {
        if (calendar.allowsContentModifications) {
            [writableCalendars addObject:calendar];
        }
    }
    
    return writableCalendars;
}

+ (EKCalendar *)calendarWithTitle:(NSString *)title {
    EKCalendar *calendar = [[[self avaibleCalendars] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKCalendar *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject.title isEqualToString:title];
    }]] firstObject];
    
    if (!calendar) {
        calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
        [calendar setTitle:title];
        
        for (EKSource *s in eventStore.sources) {
            if (s.sourceType == EKSourceTypeLocal) {
                calendar.source = s;
                break;
            }
        }
        
        NSError *error = nil;
        BOOL saved = [eventStore saveCalendar:calendar commit:YES error:&error];
        if (!saved) {
            NSLog(@"Calendar error:%@", error.localizedDescription);
            return nil;
        }
    }
    
    return calendar;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Add event
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (NSString *)addEventWithTitle:(NSString *)title calendarIdentifier:(NSString *)calendarIdentifier startDate:(NSDate *)startDate alarm:(NSDate *)alarm {
    return [self addEventWithTitle:title calendarIdentifier:calendarIdentifier startDate:startDate endDate:[startDate dateByAddingTimeInterval:3600] allDay:YES alarm:alarm alarmTimeBefore:0];
}

+ (NSString *)addEventWithTitle:(NSString *)title calendarIdentifier:(NSString *)calendarIdentifier startDate:(NSDate *)startDate endDate:(NSDate *)endDate allDay:(BOOL)allDay alarm:(NSDate *)alarm alarmTimeBefore:(NSTimeInterval)alarmTime {
    EKCalendar *aCalendar = calendarIdentifier ? [eventStore calendarWithIdentifier:calendarIdentifier] : [eventStore defaultCalendarForNewEvents];
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    
    if (!aCalendar) {
        return nil;
    }
    
    event.title     = title;
    event.startDate = startDate;
    event.endDate   = endDate;
	event.allDay = allDay;
    event.calendar = aCalendar;
    
    if(alarm) {
        event.alarms = @[ [EKAlarm alarmWithAbsoluteDate:alarm] ];
    }
    
    NSError *error = nil;
    if (![eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&error]) {
        NSLog(@"Error saving event: %@", error);
        return nil;
    }
    
    return [[NSString alloc] initWithFormat:@"%@", event.eventIdentifier];
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Remove event
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (BOOL)removeEventWithId:(NSString *)eventId {
    EKEvent *eventToRemove = [eventStore eventWithIdentifier:eventId];
    if (!eventToRemove) {
        return YES;
    }
    
    NSError* error = nil;
    if (![eventStore removeEvent:eventToRemove span:EKSpanThisEvent error:&error]) {
        NSLog(@"Error remove event: %@", error);
        return NO;
    }
    
    return YES;
}

@end
