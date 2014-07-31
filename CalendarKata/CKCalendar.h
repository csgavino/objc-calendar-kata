//
//  CKCalendar.h
//  CalendarKata
//
//  Created by Carlos Gavino on 28/7/14.
//  Copyright (c) 2014 Carlos Gavino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKCalendar : NSObject

- (id)initWithYear:(NSUInteger)year andMonth:(NSUInteger)month;
- (id)initWithYear:(NSUInteger)year withMonth:(NSUInteger)month andStartWeekOn:(NSUInteger)startWeekOn;

@end
