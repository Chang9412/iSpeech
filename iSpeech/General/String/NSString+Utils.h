//
//  NSString+Utils.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utils)

+ (NSString *)stringWithCount:(NSInteger)count;

+ (NSString *)stringWithFilesize:(NSInteger)filesize;

@end

NS_ASSUME_NONNULL_END
