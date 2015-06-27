//
//  UIColor+Custom.m
//  tataUFO
//
//  Created by Can on 9/16/14.
//  Copyright (c) 2014 tataUFO.com. All rights reserved.
//

#import "UIColor+Custom.h"
#import "UIColor+HexString.h"

@implementation UIColor (Custom)

+ (UIColor *)customColorForNavigationBar {
    return [UIColor customColorDefault];
}

+ (UIColor *)customColorDefault
{
    return [UIColor colorWithHexString:@"3CB371"];
}

+ (UIColor *)customColorYellow
{
    return [UIColor colorWithHexString:@"FFC125"];
}

+ (UIColor *)customColorRed
{
    return [UIColor colorWithHexString:@"EE2C2C"];
}

+ (UIColor *)customColorGreen
{
    return [UIColor colorWithHexString:@"228B22"];
}
@end
