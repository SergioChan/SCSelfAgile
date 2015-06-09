//
//  DBExecutingQueue.h
//  iCampus
//
//  Created by Siyu Yang on 14-9-3.
//  Copyright (c) 2014年 Siyu Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DBExecutingQueue : NSObject
+ (dispatch_queue_t)getQueue;
@end
