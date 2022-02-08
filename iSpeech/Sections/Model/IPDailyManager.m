//
//  IPDailyManager.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/4.
//

#import "IPDailyManager.h"
#import "IPDBHelper.h"

NSString * const kDailyDidChangeNotification = @"kDailyDidChangeNotification";

@implementation IPDailyManager

+ (instancetype)manager {
    static IPDailyManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IPDailyManager alloc] init];
    });
    return instance;
}

- (void)updateDailies:(NSArray *)dailies {
    [IPDBHelper batchUpdateDailies:dailies];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDailyDidChangeNotification object:nil];
}

- (void)deleteDailies:(NSArray *)dailies {
    [IPDBHelper deleteDailies:dailies];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDailyDidChangeNotification object:nil];
}

- (NSArray *)allDailies {
    return [IPDBHelper allDailies];
}




@end
