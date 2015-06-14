//
//  AppDelegate.m
//  SelfAgile
//
//  Created by chen Yuheng on 15/6/9.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "AppDelegate.h"

#import "TWMessageBarManager.h"
#import "UIColor+Custom.h"
// Strings
NSString * const kAppDelegateDemoStyleSheetImageIconError = @"icon-error.png";
NSString * const kAppDelegateDemoStyleSheetImageIconSuccess = @"icon-success.png";
NSString * const kAppDelegateDemoStyleSheetImageIconInfo = @"icon-info.png";

@interface TWAppDelegateDemoStyleSheet : NSObject <TWMessageBarStyleSheet>

+ (TWAppDelegateDemoStyleSheet *)styleSheet;

@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
@implementation TWAppDelegateDemoStyleSheet

#pragma mark - Alloc/Init

+ (TWAppDelegateDemoStyleSheet *)styleSheet
{
    return [[TWAppDelegateDemoStyleSheet alloc] init];
}

#pragma mark - TWMessageBarStyleSheet

- (UIColor *)backgroundColorForMessageType:(TWMessageBarMessageType)type
{
    UIColor *backgroundColor = nil;
    switch (type)
    {
        case TWMessageBarMessageTypeError:
            backgroundColor = [UIColor customColorRed];
            break;
        case TWMessageBarMessageTypeSuccess:
            backgroundColor = [UIColor customColorDefault];
            break;
        case TWMessageBarMessageTypeInfo:
            backgroundColor = [UIColor customColorYellow];
            break;
        default:
            break;
    }
    return backgroundColor;
}

- (UIColor *)strokeColorForMessageType:(TWMessageBarMessageType)type
{
    UIColor *strokeColor = nil;
    switch (type)
    {
        case TWMessageBarMessageTypeError:
            strokeColor = [UIColor customColorRed];
            break;
        case TWMessageBarMessageTypeSuccess:
            strokeColor = [UIColor customColorDefault];
            break;
        case TWMessageBarMessageTypeInfo:
            strokeColor = [UIColor customColorYellow];
            break;
        default:
            break;
    }
    return strokeColor;
}

- (UIImage *)iconImageForMessageType:(TWMessageBarMessageType)type
{
    UIImage *iconImage = nil;
    switch (type)
    {
        case TWMessageBarMessageTypeError:
            iconImage = [UIImage imageNamed:kAppDelegateDemoStyleSheetImageIconError];
            break;
        case TWMessageBarMessageTypeSuccess:
            iconImage = [UIImage imageNamed:kAppDelegateDemoStyleSheetImageIconSuccess];
            break;
        case TWMessageBarMessageTypeInfo:
            iconImage = [UIImage imageNamed:kAppDelegateDemoStyleSheetImageIconInfo];
            break;
        default:
            break;
    }
    return iconImage;
}


@end
