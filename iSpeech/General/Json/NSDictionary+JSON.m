//
//  NSDictionary+JSON.m
//  App
//
//  Created by m on 16/3/22.
//  Copyright © 2016年 上海宝云网络. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

+ (NSDictionary *)dictFromJson:(NSString *)json {
    if (!json || json.length == 0) {
        return @{};
    }
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
}

- (NSString *)jsonString {
    @try {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:NULL];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        NSLog(@"%@, %@", self, exception);
        return @"{}";
    }
}

@end
