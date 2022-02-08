//
//  UIImageView+App.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^IPImageCompletionBlock)(UIImage * _Nullable image, NSError * _Nullable error);

@interface UIImageView (App)

- (void)app_setUrl:(NSString *)url;
- (void)app_setUrl:(NSString *)url placeholderImage:(UIImage *)image;
- (void)app_setImageWithURL:(nullable NSString *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable IPImageCompletionBlock)completedBlock;



@end

NS_ASSUME_NONNULL_END
