//
//  IPFile.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/21.
//

#import "IPFile.h"

@implementation IPFile

- (NSString *)createDateString {
    if (_createDate) {
        return [IPFile stringForDate:_createDate];
    }
    return @"";
}

+ (NSString *)stringForDate:(NSDate *)date {
    static NSDateFormatter *formmatter;
    if (!formmatter) {
        formmatter = [[NSDateFormatter alloc] init];
        formmatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ";
    }
    return [formmatter stringFromDate:date];
}

@end
