//
//  NSString+Utils.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/2/8.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

+ (NSString *)stringWithCount:(NSInteger)count {
    if (count > 10000) {
        return [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    }
    return [NSString stringWithFormat:@"%ld万", count];
}

+ (NSString *)stringWithFilesize:(NSInteger)filesize {
    if (filesize > 1000000) {
        return [NSString stringWithFormat:@"%.1fMB", filesize / 1000000.0];
    }
    if (filesize > 1000) {
        return [NSString stringWithFormat:@"%.1fKB", filesize / 1000.0];
    }
    return [NSString stringWithFormat:@"%ldB", filesize];
}

@end
