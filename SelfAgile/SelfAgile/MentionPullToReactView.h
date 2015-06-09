//
//  MentionPullToReactView.h
//  ExampleCustomContent
//
//  Created by Guillaume Sempe on 28/05/2014.
//  Copyright (c) 2014 mention.com. All rights reserved.
//

#import "MNTPullToReactView.h"

#define MentionPullToReactViewNumberOfAction 3

typedef NS_ENUM(NSInteger, MNTMentionHeaderActions)
{
    mntMentionHeaderActionTodo = 0,
    mntMentionHeaderActionDoing = 1,
    mntMentionHeaderActionDone = 2,
};

@interface MentionPullToReactView : MNTPullToReactView

@end
