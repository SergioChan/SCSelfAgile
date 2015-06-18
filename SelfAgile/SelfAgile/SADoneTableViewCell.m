//
//  SADoneTableViewCell.m
//  SelfAgile
//
//  Created by chen Yuheng on 15/6/9.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "SADoneTableViewCell.h"
#import "UIViewExt.h"
#import "UIColor+Custom.h"
#import "UIKitCustomUtils.h"
#import "StringConstant.h"

@interface SADoneTableViewCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *dueDateLabel;
@property (nonatomic,strong) UILabel *dueDatePrefixLabel;
@property (nonatomic,strong) UILabel *levelLabel;
@property (nonatomic,strong) UILabel *pointLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@end

@implementation SADoneTableViewCell

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
        [self  initSubViews];
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
    
    _pointLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _pointLabel.textAlignment = NSTextAlignmentCenter;
    _pointLabel.font = [UIFont systemFontOfSize:10.0f];
    _pointLabel.textColor = [UIColor whiteColor];
    _pointLabel.backgroundColor = [UIColor customColorDefault];
    _pointLabel.clipsToBounds = YES;
    _pointLabel.layer.cornerRadius = 3.0f;
    [self.contentView addSubview:_pointLabel];
    
    _dueDatePrefixLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _dueDatePrefixLabel.text = DoneDueDateLabelText;
    _dueDatePrefixLabel.textAlignment = NSTextAlignmentLeft;
    _dueDatePrefixLabel.font = [UIFont systemFontOfSize:11.0f];
    _dueDatePrefixLabel.textColor = [UIColor customColorDefault];
    _dueDatePrefixLabel.numberOfLines = 1;
    [self.contentView addSubview:_dueDatePrefixLabel];
    
    _dueDateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _dueDateLabel.font = [UIFont systemFontOfSize:13.0f];
    _dueDateLabel.textColor = [UIColor lightGrayColor];
    _dueDateLabel.numberOfLines = 1;
    [self.contentView addSubview:_dueDateLabel];
    
    _levelLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _levelLabel.font = [UIFont systemFontOfSize:11.0f];
    _levelLabel.textColor = [UIColor whiteColor];
    _levelLabel.backgroundColor = [UIColor customColorDefault];
    _levelLabel.numberOfLines = 1;
    _levelLabel.textAlignment = NSTextAlignmentCenter;
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
    
     _pointLabel.frame = CGRectMake(10.0f, _titleLabel.bottom + 10.0f, 15.0f, 15.0f);
    
    CGFloat prefixWidth = [UIKitCustomUtils getTextWidthWithText:DoneDueDateLabelText andMaxHeight:15.0f andFont:[UIFont systemFontOfSize:11.0f]];
    _dueDatePrefixLabel.frame = CGRectMake(_pointLabel.right + 3.0f, _titleLabel.bottom + 10.0f, prefixWidth, 15.0f);
    
    _dueDateLabel.frame = CGRectMake(_dueDatePrefixLabel.right, _titleLabel.bottom + 10.0f, 100.0f, 15.0f);
    _dueDateLabel.text = [self.event objectForKey:@"endDate"];
    
    NSString *levelText = @"Take it easy";
    switch([[self.event objectForKey:@"level"] integerValue])
    {
        case 1:
        {
            levelText = @"Normal";
            _levelLabel.backgroundColor = [UIColor customColorYellow];
        }
            break;
        case 2:
        {
            levelText = @"Urgent";
            _levelLabel.backgroundColor = [UIColor customColorRed];
        }
            break;
        default:
        {
            levelText = @"Take it easy";
            _levelLabel.backgroundColor = [UIColor customColorDefault];
        }
            break;
    }
    _levelLabel.frame = CGRectMake(ScreenWidth - 70.0f, _dueDateLabel.top, 70.0f, 15.0f);
    _levelLabel.text = levelText;
    _pointLabel.text = [self.event objectForKey:@"points"];
    
    CGFloat contentHeight = [UIKitCustomUtils getTextHeightWithText:[self.event objectForKey:@"content"] andMaxWidth:ScreenWidth - 20.0f andFont:[UIFont systemFontOfSize:14.0f]];
    _contentLabel.frame = CGRectMake(10.0f, _dueDateLabel.bottom + 10.0f, ScreenWidth - 20.0f, contentHeight);
    _contentLabel.text = [self.event objectForKey:@"content"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
