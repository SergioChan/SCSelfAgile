//
//  DictionaryJSONStringConvertor.h
//  iCampus
//
//  Created by Siyu Yang on 14-8-15.
//  Copyright (c) 2014年 Siyu Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryJSONStringConvertor : NSObject

+ (NSString *)dictToString:(NSDictionary *)dict;
+ (NSDictionary *)stringToDict:(NSString *)str;
+ (NSString *)dictToJSONString:(NSDictionary *)dict;

@end
