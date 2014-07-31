//
//  CalendarKataTests.m
//  CalendarKataTests
//
//  Created by Carlos Gavino on 28/7/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CKCalendar.h"

@interface CalendarKataTests : XCTestCase

@end

@implementation CalendarKataTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAugust2014
{
    CKCalendar *calendar = [[CKCalendar alloc] initWithYear:2014 andMonth:8];
    NSString *august = @" August 2014\n"
                        " Sun Mon Tue Wed Thu Fri Sat\n"
                        "                       1   2\n"
                        "   3   4   5   6   7   8   9\n"
                        "  10  11  12  13  14  15  16\n"
                        "  17  18  19  20  21  22  23\n"
                        "  24  25  26  27  28  29  30\n"
                        "  31";

    XCTAssertEqualObjects([calendar description], august);
}

- (void)testFeb2012
{
    CKCalendar *calendar = [[CKCalendar alloc] initWithYear:2012 withMonth:2 andStartWeekOn:5];
    NSString *feb = @" February 2012\n"
                     " Thu Fri Sat Sun Mon Tue Wed\n"
                     "                           1\n"
                     "   2   3   4   5   6   7   8\n"
                     "   9  10  11  12  13  14  15\n"
                     "  16  17  18  19  20  21  22\n"
                     "  23  24  25  26  27  28  29";
    
    XCTAssertEqualObjects([calendar description], feb);
}

- (void)testJuly2014
{
    CKCalendar *calendar = [[CKCalendar alloc] initWithYear:2014 andMonth:7];
    NSString *july = @" July 2014\n"
                      " Sun Mon Tue Wed Thu Fri Sat\n"
                      "           1   2   3   4   5\n"
                      "   6   7   8   9  10  11  12\n"
                      "  13  14  15  16  17  18  19\n"
                      "  20  21  22  23  24  25  26\n"
                      "  27  28  29  30  31";

    
    XCTAssertEqualObjects([calendar description], july);
}

@end
