//
//  CKCalendar.m
//  CalendarKata
//
//  Created by Carlos Gavino on 28/7/14.
//  Copyright (c) 2014 Carlos Gavino. All rights reserved.
//

#import "CKCalendar.h"


@interface CKCalendar ()

@property (nonatomic, strong) NSDate *date;
@property (nonatomic) NSUInteger startWeekOn;

@end

@implementation CKCalendar

- (id)initWithYear:(NSUInteger)year andMonth:(NSUInteger)month {
    self = [super init];
    return [self initWithYear:year withMonth:month andStartWeekOn:1];
}

- (id)initWithYear:(NSUInteger)year withMonth:(NSUInteger)month andStartWeekOn:(NSUInteger)startWeekOn {
    self = [super init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:1];
    
    self.date = [calendar dateFromComponents:components];
    self.startWeekOn = startWeekOn;
    
    return self;
}

- (NSString *)title {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@" MMMM YYYY"];
    return [format stringFromDate:self.date];
}

- (NSString *)header {
    NSMutableArray *header = [[NSMutableArray alloc] init];
    NSArray *days = [NSArray arrayWithObjects:@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", nil];
    NSMutableArray *daysDays = [[NSMutableArray alloc] init];
    [daysDays addObjectsFromArray:days];
    [daysDays addObjectsFromArray:days];

    NSArray *daysSlice = [daysDays subarrayWithRange:NSMakeRange(self.startWeekOn - 1, 7)];

    [header addObject:@" "];
    [header addObject:[daysSlice componentsJoinedByString:@" "]];
    
    return [header componentsJoinedByString:@""];
}

- (NSMutableArray *)daysThisMonth {
    NSMutableArray *days = [[NSMutableArray alloc] init];
    NSUInteger lastDayOfMonth = [self lastDayOfMonth];
    for (NSUInteger idx = 1; idx <= lastDayOfMonth; idx++) {
        NSNumber *day = [NSNumber numberWithUnsignedInt:idx];
        [days addObject:day];
    }
    return days;
}

- (NSUInteger)lastDayOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange daysRange = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.date];
    return daysRange.length;
}

- (NSMutableArray *)insertObjects:(NSUInteger)object toDays:days withCount:(NSUInteger)count {
    NSMutableArray *daysWithZeroes = [NSMutableArray arrayWithArray:days];
    NSNumber *zero = [NSNumber numberWithUnsignedInt:object];

    for (NSUInteger idx = 1; idx <= count; idx++) {
        [daysWithZeroes insertObject:zero atIndex:0];
    }
    
    return daysWithZeroes;
}

- (NSMutableArray *)formatDays:(NSMutableArray *)days {
    NSMutableArray *formatDays = [[NSMutableArray alloc] init];
    NSString *format = @"%4.d";

    for (NSUInteger idx = 0; idx < [days count]; idx++) {
        NSUInteger oldValue = [[days objectAtIndex:idx] intValue];
        [formatDays addObject:[NSString stringWithFormat:format, oldValue]];
    }

    return formatDays;
}

- (NSMutableArray *)sliceObjects:(NSMutableArray *)input intoSections:(NSUInteger)chunk {
    NSMutableArray *output = [[NSMutableArray alloc] init];
    NSUInteger count = [input count];
    float sections = (float) count / chunk;

    NSUInteger lowerBound;
    NSUInteger length;

    for (NSUInteger week = 0; week < ceil(sections); week++) {
        lowerBound = week * chunk;
        
        bool lastWeek = (lowerBound + chunk + 1) > count;
        if (lastWeek) {
            length = count - lowerBound;
        } else {
            length = chunk;
        }
        
        NSArray *subset = [input subarrayWithRange:NSMakeRange(lowerBound, length)];
        [output addObject:[subset componentsJoinedByString:@""]];
    }
    
    return output;
}

- (NSUInteger)daysOffset {
    return (7 + [self firstWeekdayOrdinal] - [self startWeekOnDay]) % 7;
}

- (NSUInteger)firstWeekdayOrdinal {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:self.date];
    return [components weekday];
}

- (NSUInteger)startWeekOnDay {
    return self.startWeekOn;
}

- (NSString *)days {
    NSMutableArray *days = [self daysThisMonth];
    NSUInteger daysOffset = [self daysOffset];

    days = [self insertObjects:0 toDays:days withCount:daysOffset];
    days = [self formatDays:days];
    days = [self sliceObjects:days intoSections:7];

    return [days componentsJoinedByString:@"\n"];
}

- (NSString *)description {
    NSMutableArray *output = [[NSMutableArray alloc] init];

    [output addObject:[self title]];
    [output addObject:[self header]];
    [output addObject:[self days]];

    return [output componentsJoinedByString:@"\n"];
}

@end
