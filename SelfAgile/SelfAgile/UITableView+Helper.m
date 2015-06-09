//
//  UITableView+Helper.m
//  tataUFO
//
//  Created by tataufo_howeguo on 9/28/14.
//  Copyright (c) 2014 tataUFO.com. All rights reserved.
//

#import "UITableView+Helper.h"

@implementation UITableView (Helper)
- (void) hideExtraCellLine
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}
@end
