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
+ (void)createEvents:(NSDictionary *)event;

/**
 *  alter Events state
 *
 *  @param eventId
 *  @param desState destination state value
 */
+ (void)alterEvents:(NSInteger)eventId toState:(NSInteger)desState;

/**
 *  get todo event list
 *
 *  @param sprintNum current sprintNum
 *
 *  @return event list
 */
+ (id)getToDoEventList:(NSInteger)sprintNum;

/**
 *  get doing event list
 *
 *  @param sprintNum current sprintNum
 *
 *  @return event list
 */
+ (id)getDoingEventList:(NSInteger)sprintNum;

/**
 *  get done event list
 *
 *  @param sprintNum current sprintNum
 *
 *  @return event list
 */
+ (id)getDoneEventList:(NSInteger)sprintNum;
@end
