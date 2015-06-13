//
//  SAEvent.m
//  SelfAgile
//
//  Created by chen Yuheng on 15/6/9.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "SAEvent.h"
#import "DBManager.h"
#import "DictionaryJSONStringConvertor.h"

static DBManager *dbManager;
@implementation SAEvent

+ (void)initDBManager
{
    if (dbManager == nil) {
        dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SelfAgile.db"];
    }
}

+ (BOOL)createEvents:(NSDictionary *)event
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"insert into Events(title,content,level,sprintNum,endDate) values('%@','%@',%d,%d,'%@')",[event objectForKey:@"title"],[event objectForKey:@"content"],[[event objectForKey:@"level"] intValue],[[event objectForKey:@"sprintNum"] intValue],[event objectForKey:@"endDate"]];
    [dbManager executeQuery:query];
    if (dbManager.affectedRows != 0) {
        NSLog(@"Save event successfully. Affected rows = %d", dbManager.affectedRows);
        return YES;
    } else {
        NSLog(@"Could not execute the query");
        return NO;
    }
}

+ (void)alterEvents:(NSInteger)eventId toState:(NSInteger)desState
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"update Events set state = %ld where id = %ld",desState,eventId];
    [dbManager executeQuery:query];
    if (dbManager.affectedRows != 0) {
        NSLog(@"alter event successfully. Affected rows = %d", dbManager.affectedRows);
    } else {
        NSLog(@"Could not execute the query");
    }
}

+ (NSMutableArray *)getToDoEventList:(NSInteger)sprintNum
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select * from Events where sprintNum = %ld and state = 0",sprintNum];
    NSArray *result = [dbManager loadDataFromDB:query];
    NSMutableArray *eventsList = [NSMutableArray array];
    if (result.count > 0) {
        for (NSDictionary *event in result) {
            [eventsList addObject:event];
        }
        return eventsList;
    }
    else
    {
        return eventsList;
    }
}

+ (NSMutableArray *)getDoingEventList:(NSInteger)sprintNum
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select * from Events where sprintNum = %ld and state = 1",sprintNum];
    NSArray *result = [dbManager loadDataFromDB:query];
    NSMutableArray *eventsList = [NSMutableArray array];
    if (result.count > 0) {
        for (NSDictionary *event in result) {
            [eventsList addObject:event];
        }
        return eventsList;
    }
    else
    {
        return eventsList;
    }
}

+ (NSMutableArray *)getDoneEventList:(NSInteger)sprintNum
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select * from Events where sprintNum = %ld and state = 2",sprintNum];
    NSArray *result = [dbManager loadDataFromDB:query];
    NSMutableArray *eventsList = [NSMutableArray array];
    if (result.count > 0) {
        for (NSDictionary *event in result) {
            [eventsList addObject:event];
        }
        return eventsList;
    }
    else
    {
        return eventsList;
    }
}
@end
