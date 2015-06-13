//
//  ViewControllerCommonUtils.m
//  tataUFO
//
//  Created by gshmac on 13-8-9.
//  Copyright (c) 2013年 tataUFO.com. All rights reserved.
//

#import "UIKitCustomUtils.h"

@interface UIKitCustomUtils ()

@end

@implementation UIKitCustomUtils

+(UIKitCustomUtils*)sharedInstance
{
    static dispatch_once_t  onceToken;
    static UIKitCustomUtils * sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UIKitCustomUtils alloc] init];
    });
    return sharedInstance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//获取视图的视图控制器
+ (UIViewController*)viewControllerOfSuperView:(UIView *)subView
{
    for (UIView *next = [subView superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//根据颜色生成图片
+ (UIImage *) imageFromColor:(UIColor *)color andFrame:(CGRect) rect{

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (CGFloat) getTextWidthWithText:(NSString *) text andMaxHeight:(CGFloat) maxHeight andFont:(UIFont *) font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(size.width);
}

+ (CGFloat) getTextHeightWithText:(NSString *) text andMaxWidth:(CGFloat) maxWidth andFont:(UIFont *) font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(size.height);
}

@end
