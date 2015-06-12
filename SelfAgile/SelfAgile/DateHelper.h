//
//  DateHelper.h
//  tataUFO
//
//  Created by gshmac on 13-8-9.
//  Copyright (c) 2013年 tataUFO.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+(NSString *)getFormatterDateStringFromDate:(NSDate *)date andFormatter:(NSString *)formatter;
+(NSDate *)getFormatterDateFromString:(NSString *)dateString andFormatter:(NSString *)formatter;
+(NSDateComponents *)getDateComponentFromDate:(NSDate *)date;

@end
