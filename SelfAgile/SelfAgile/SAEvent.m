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
    NSInteger index = [self getMaxIndex] + 1;
    NSString *query = [NSString stringWithFormat:@"insert into Events(title,content,level,sprintNum,endDate,customIndex,points) values('%@','%@',%d,%d,'%@',%ld,%ld)",[event objectForKey:@"title"],[event objectForKey:@"content"],[[event objectForKey:@"level"] intValue],[[event objectForKey:@"sprintNum"] intValue],[event objectForKey:@"endDate"],index,[[event objectForKey:@"points"] integerValue]];
    [dbManager executeQuery:query];
    if (dbManager.affectedRows != 0) {
        NSLog(@"Save event successfully. Affected rows = %d", dbManager.affectedRows);
        return YES;
    } else {
        NSLog(@"Could not execute the query");
        return NO;
    }
}

+ (NSInteger)getMaxIndex
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select MAX(customIndex) as tmp from Events"];
    NSArray *result = [dbManager loadDataFromDB:query];
    return [[[result objectAtIndex:0] objectForKey:@"tmp"] integerValue];
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

+ (void)deleteEvent:(NSInteger)eventId
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"delete from Events where id = %ld",eventId];
    [dbManager executeQuery:query];
    if (dbManager.affectedRows != 0) {
        NSLog(@"delete event successfully. Affected rows = %d", dbManager.affectedRows);
    } else {
        NSLog(@"Could not execute the query");
    }
}

+ (void)exchangeCustomIndexFronEvent:(NSDictionary *)sourceEvent withEvent:(NSDictionary *)desEvent
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"update Events set customIndex = %ld where id = %ld",[[desEvent objectForKey:@"customIndex"] integerValue],[[sourceEvent objectForKey:@"id"] integerValue]];
    [dbManager executeQuery:query];
    if (dbManager.affectedRows != 0) {
        NSString *query_2 = [NSString stringWithFormat:@"update Events set customIndex = %ld where id = %ld",[[sourceEvent objectForKey:@"customIndex"] integerValue],[[desEvent objectForKey:@"id"] integerValue]];
        [dbManager executeQuery:query_2];
    } else {
        NSLog(@"Could not execute the query");
    }
}

+ (NSMutableArray *)getToDoEventList:(NSInteger)sprintNum
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select * from Events where sprintNum = %ld and state = 0 order by customIndex desc",sprintNum];
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
    NSString *query = [NSString stringWithFormat:@"select * from Events where sprintNum = %ld and state = 1 order by customIndex desc",sprintNum];
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
    NSString *query = [NSString stringWithFormat:@"select * from Events where sprintNum = %ld and state = 2 order by customIndex desc",sprintNum];
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

+ (NSInteger)getCurrentSprintCardCount:(NSInteger)sprintNum
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select count(*) as tmp from Events where sprintNum = %ld",sprintNum];
    NSArray *result = [dbManager loadDataFromDB:query];
    return [[[result objectAtIndex:0] objectForKey:@"tmp"] integerValue];
}

+ (NSInteger)getCurrentSprintTodoPointTotal:(NSInteger)sprintNum
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select sum(points) as tmp from Events where sprintNum = %ld and state = 0",sprintNum];
    NSArray *result = [dbManager loadDataFromDB:query];
    return [[[result objectAtIndex:0] objectForKey:@"tmp"] integerValue];
}

+ (NSInteger)getCurrentSprintDoingPointTotal:(NSInteger)sprintNum
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select sum(points) as tmp from Events where sprintNum = %ld and state = 1",sprintNum];
    NSArray *result = [dbManager loadDataFromDB:query];
    return [[[result objectAtIndex:0] objectForKey:@"tmp"] integerValue];
}

+ (NSInteger)getCurrentSprintDonePointTotal:(NSInteger)sprintNum
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"select sum(points) as tmp from Events where sprintNum = %ld and state = 2",sprintNum];
    NSArray *result = [dbManager loadDataFromDB:query];
    return [[[result objectAtIndex:0] objectForKey:@"tmp"] integerValue];
}
@end
