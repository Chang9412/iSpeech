//
//  UIImageView+App.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/10.
//

#import "UIImageView+App.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+Utils.h"

@implementation UIImageView (App)

+ (UIImage *)app_placeholer {
    static UIImage *placeholder;
    if (placeholder) {
        return placeholder;
    }
    placeholder = [UIImage imageWithColor:[UIColor colorWithRGB:0xe8e8e8]];
    return placeholder;
}
- (void)app_setUrl:(NSString *)url {
    [self app_setUrl:url placeholderImage:[UIImageView app_placeholer]];
}

- (void)app_setUrl:(NSString *)url placeholderImage:(UIImage *)image {
    [self app_setImageWithURL:url placeholderImage:image completed:nil];
}


- (void)app_setImageWithURL:(nullable NSString *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable IPImageCompletionBlock)completedBlock {
    
    if (!url || url.length == 0) {
        self.image = placeholder;
        return;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];

}


@end
