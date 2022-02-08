//
//  AppDelegate.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/30.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <FCFileManager.h>
#import "IPRecognizerHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    IPNavigationController *nav = [[IPNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"%@", url);// 沙盒路径
    if (!url) {
        return NO;
    }
    
    return [IPRecognizerHelper openUrl:url];
}

@end
