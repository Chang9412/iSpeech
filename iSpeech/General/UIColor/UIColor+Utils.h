//
//  UIColor+Utils.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import <UIKit/UIKit.h>
#import <UIColor+Chameleon.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Utils)

+ (UIColor *)colorWithRGB:(NSInteger)rgb;

+ (UIColor *)colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha;

+ (UIColor *)progressedColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(float)progress;

+ (UIColor *)random;

@end

NS_ASSUME_NONNULL_END
