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

+ (UIColor *)customColorDefault; {
    //return [UIColor colorWithRed:0.0f green:210.0f/255.0f blue:120.0f/255.0f alpha:1.0f];
    //00D278
    return [UIColor colorWithHexString:@"00D278"];
}

@end
