//
//  NSArray+JSON.m
//  App
//
//  Created by m on 16/3/22.
//  Copyright © 2016年 上海宝云网络. All rights reserved.
//

#import "NSArray+JSON.h"

@implementation NSArray (JSON)

- (NSString *)jsonString {
    @try {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return @"[]";
    }
}

+ (NSArray *)fromJsonString:(NSString *)s {
    if (!s || s.length == 0) {
        return @[];
    }
    return [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
}

@end
