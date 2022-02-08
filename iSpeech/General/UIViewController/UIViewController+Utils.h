//
//  UIViewController+Utils.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Utils)

+ (UIViewController *)topViewController;
+ (UINavigationController *)topNavigationViewController;

@end

NS_ASSUME_NONNULL_END
