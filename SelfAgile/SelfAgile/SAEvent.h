//
//  SAEvent.h
//  SelfAgile
//
//  Created by chen Yuheng on 15/6/9.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAEvent : NSObject

/**
 *  create Events
 *
 *  @param event {title,content,level,sprintNum}
 */
+ (BOOL)createEvents:(NSDictionary *)event;

/**
 *  alter Events state
 *
 *  @param eventId
 *  @param desState destination state value
 */
+ (void)alterEvents:(NSInteger)eventId toState:(NSInteger)desState;

/**
 *  exchange events with custom Index to sort
 *
 *  @param sourceEvent
 *  @param desEvent
 */
+ (void)exchangeCustomIndexFronEvent:(NSDictionary *)sourceEvent withEvent:(NSDictionary *)desEvent;

/**
 *  delete event using event id
 *
 *  @param eventId
 */
+ (void)deleteEvent:(NSInteger)eventId;

/**
 *  get todo event list
 *
 *  @param sprintNum current sprintNum
 *
 *  @return event list
 */
+ (NSMutableArray *)getToDoEventList:(NSInteger)sprintNum;

/**
 *  get doing event list
 *
 *  @param sprintNum current sprintNum
 *
 *  @return event list
 */
+ (NSMutableArray *)getDoingEventList:(NSInteger)sprintNum;

/**
 *  get done event list
 *
 *  @param sprintNum current sprintNum
 *
 *  @return event list
 */
+ (NSMutableArray *)getDoneEventList:(NSInteger)sprintNum;
@end
