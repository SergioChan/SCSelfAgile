//
//  ViewControllerCommonUtils.h
//  tataUFO
//
//  Created by gshmac on 13-8-9.
//  Copyright (c) 2013年 tataUFO.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UIKitCustomUtils : UIViewController

+ (CGFloat) getTextWidthWithText:(NSString *) text andMaxHeight:(CGFloat) maxHeight andFont:(UIFont *) font;
+ (CGFloat) getTextHeightWithText:(NSString *) text andMaxWidth:(CGFloat) maxWidth andFont:(UIFont *) font;
+ (UIViewController*)viewControllerOfSuperView:(UIView *)subView;
+ (UIImage *) imageFromColor:(UIColor *)color andFrame:(CGRect) rect;
+ (UIKitCustomUtils*)sharedInstance;
@end


