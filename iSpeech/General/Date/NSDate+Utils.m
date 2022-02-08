//
//  NSDate+Utils.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import "NSDate+Utils.h"
#import <NSDate+Additions.h>

static NSDateFormatter *sformatter;

@implementation NSDate (Utils)

+ (NSString *)timeStringForDate:(NSDate *)date {
    NSDate *currentDate = [NSDate now];
    NSInteger days = [date daysBeforeDate:currentDate];
    if (days > 7) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([date isThisYear]) {
            formatter.dateFormat = @"MM-dd";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd";
        }
        return [formatter stringFromDate:date];
    }
    if (days > 0) {
        return [NSString stringWithFormat:@"%@天前",@(days)];
    } else {
        NSInteger hours = [date hoursBeforeDate:currentDate];
        if (hours > 0) {
            return [NSString stringWithFormat:@"%@小时前",@(hours)];
        } else {
            NSInteger minutes = [date minutesBeforeDate:currentDate];
            if (minutes > 0) {
                return [NSString stringWithFormat:@"%@分钟前",@(minutes)];
            }
            return @"刚刚";
        }
    }
}

+ (NSString *)messageTimeStringForDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([date isThisYear]) {
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yy-MM-dd HH:mm";
    }
    return [formatter stringFromDate:date];
}

@end
