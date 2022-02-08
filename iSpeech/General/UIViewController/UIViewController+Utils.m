//
//  UIViewController+Utils.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/12.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

+ (UIViewController *)topViewController {
    return [self topViewControllerForWindow:nil];
}

+ (UIViewController *)topViewControllerForWindow:(UIWindow *)window {
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        return nil;
    }
    UIViewController *root = window.rootViewController;
    if (!root) {
        return nil;
    }
    UIViewController *vc = root;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    return vc;
}

+ (UINavigationController *)topNavigationViewController {
    UINavigationController *nav = nil;
    UIViewController *topVC = [UIViewController topViewController];
    if ([topVC isKindOfClass:[UITabBarController class]]) {
        topVC = [(UITabBarController *)topVC selectedViewController];
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)topVC;
    }
    return nav;
}


@end
