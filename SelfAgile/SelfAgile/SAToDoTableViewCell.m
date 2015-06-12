//
//  SAToDoTableViewCell.m
//  SelfAgile
//
//  Created by chen Yuheng on 15/6/9.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "SAToDoTableViewCell.h"
#import "UIViewExt.h"
#import "UIColor+Custom.h"

@implementation SAToDoTableViewCell

- (void)awakeFromNib {
    [self initSubViews];
    // Initialization code
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}

- (void) initSubViews
{
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
    topLine.backgroundColor = [UIColor customColorDefault];
    [self.contentView addSubview:topLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
