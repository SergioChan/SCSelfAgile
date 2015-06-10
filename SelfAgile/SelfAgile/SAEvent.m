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

+ (void)createEvents:(NSDictionary *)event
{
    [self initDBManager];
    NSString *query = [NSString stringWithFormat:@"insert into Events(title,content,level,sprintNum) values('%@','%@',%d,%d)",[event objectForKey:@"title"],[event objectForKey:@"content"],[[event objectForKey:@"level"] intValue],[[event objectForKey:@"sprintNum"] intValue]];
    [dbManager executeQuery:query];
    if (dbManager.affectedRows != 0) {
        NSLog(@"Save event successfully. Affected rows = %d", dbManager.affectedRows);
    } else {
        NSLog(@"Could not execute the query");
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

+ (id)getToDoEventList:(NSInteger)sprintNum
{
    [self initDBManager];
    return nil;
}

+ (id)getDoingEventList:(NSInteger)sprintNum
{
    [self initDBManager];
    return nil;
}

+ (id)getDoneEventList:(NSInteger)sprintNum
{
    [self initDBManager];
    return nil;
}
@end
