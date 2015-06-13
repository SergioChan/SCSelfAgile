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
#import "UIKitCustomUtils.h"

@interface SAToDoTableViewCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *dueDateLabel;
@property (nonatomic,strong) UILabel *levelLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@end

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
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 5.0f)];
    topLine.backgroundColor = [UIColor customColorDefault];
    [self.contentView addSubview:topLine];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    _titleLabel.textColor = [UIColor darkGrayColor];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    _dueDateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _dueDateLabel.font = [UIFont systemFontOfSize:13.0f];
    _dueDateLabel.textColor = [UIColor lightGrayColor];
    _titleLabel.numberOfLines = 1;
    [self.contentView addSubview:_dueDateLabel];
    
    _levelLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _levelLabel.layer.cornerRadius = 6.0f;
    _levelLabel.font = [UIFont systemFontOfSize:13.0f];
    _levelLabel.textColor = [UIColor whiteColor];
    _levelLabel.backgroundColor = [UIColor customColorDefault];
    _titleLabel.numberOfLines = 1;
    [self.contentView addSubview:_levelLabel];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _contentLabel.font = [UIFont systemFontOfSize:14.0f];
    _contentLabel.textColor = [UIColor lightGrayColor];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleHeight = [UIKitCustomUtils getTextHeightWithText:[self.event objectForKey:@"title"] andMaxWidth:ScreenWidth - 20.0f andFont:[UIFont boldSystemFontOfSize:18.0f]];
    _titleLabel.frame = CGRectMake(10.0f, 15.0f, ScreenWidth - 20.0f, titleHeight);
    _titleLabel.text = [self.event objectForKey:@"title"];
    
    _dueDateLabel.frame = CGRectMake(10.0f, _titleLabel.bottom + 10.0f, 100.0f, 15.0f);
    _dueDateLabel.text = [self.event objectForKey:@"endDate"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
