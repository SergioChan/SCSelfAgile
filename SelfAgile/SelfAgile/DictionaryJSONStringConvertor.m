//
//  DictionaryJSONStringConvertor.m
//  iCampus
//
//  Created by Siyu Yang on 14-8-15.
//  Copyright (c) 2014年 Siyu Yang. All rights reserved.
//

#import "DictionaryJSONStringConvertor.h"
#import "SBJson4.h"

@implementation DictionaryJSONStringConvertor

+ (NSString *)dictToString:(NSDictionary *)dict
{
    NSData *plist = [NSPropertyListSerialization
                     dataWithPropertyList:dict
                     format:NSPropertyListXMLFormat_v1_0
                     options:kNilOptions
                     error:NULL];
    
    NSString *str = [[NSString alloc] initWithData:plist encoding:NSUTF8StringEncoding];
    return str;
}

+ (NSDictionary *)stringToDict:(NSString *)str
{
    NSDictionary *dict = [NSPropertyListSerialization
                          propertyListWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                          options:kNilOptions
                          format:NULL
                          error:NULL];
    
    return dict;
}

+ (NSString *)dictToJSONString:(NSDictionary *)dict
{
    SBJson4Writer *writer = [[SBJson4Writer alloc] init];
    return [writer stringWithObject:dict];
}

@end
