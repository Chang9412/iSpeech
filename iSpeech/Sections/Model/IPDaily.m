//
//  IPDaily.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import "IPDaily.h"
#import <MJExtension.h>
#import "NSDictionary+Json.h"

@implementation IPAudio

+ (instancetype)audioWithDict:(NSDictionary *)dict {
    IPAudio *audio = [IPAudio mj_objectWithKeyValues:dict];
    return audio;
}

- (NSString *)audioString {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"content"] = self.content;
    dict[@"url"] = self.url;
    dict[@"createTime"] = @(self.createTime);
    dict[@"duration"] = @(self.duration);
    return [dict jsonString];
}

@end

@implementation IPDaily

+ (instancetype)dailyWithDict:(NSDictionary *)dict {
    IPDaily *daily = [IPDaily mj_objectWithKeyValues:dict];
    return daily;
}

@end
