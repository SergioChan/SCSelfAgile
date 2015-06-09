//
//  DBExecutingQueue.m
//  iCampus
//
//  Created by Siyu Yang on 14-9-3.
//  Copyright (c) 2014年 Siyu Yang. All rights reserved.
//

#import "DBExecutingQueue.h"

static dispatch_queue_t queue;

@implementation DBExecutingQueue

+ (dispatch_queue_t)getQueue
{
    if (queue == nil) {
        queue = dispatch_queue_create("dbExecutingQueue", NULL);
    }
    return queue;
}

@end
