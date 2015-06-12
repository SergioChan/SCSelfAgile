//
//  DateHelper.m
//  tataUFO
//
//  Created by gshmac on 13-8-9.
//  Copyright (c) 2013年 tataUFO.com. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+(NSString *)getFormatterDateStringFromDate:(NSDate *)date andFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

+(NSDate *)getFormatterDateFromString:(NSString *)dateString andFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:dateString];
}

+(NSDateComponents *)getDateComponentFromDate:(NSDate *)date
{
    NSCalendar *calender=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp=nil;
    NSInteger unitFlags= NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comp=[calender components:unitFlags fromDate:date];
    return comp;
}

@end
