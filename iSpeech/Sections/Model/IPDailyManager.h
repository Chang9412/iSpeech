//
//  IPDailyManager.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/4.
//

#import <Foundation/Foundation.h>
#import "IPDaily.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kDailyDidChangeNotification;

@interface IPDailyManager : NSObject

+ (instancetype)manager;

- (void)updateDailies:(NSArray *)dailies;
- (void)deleteDailies:(NSArray *)dailies;
- (NSArray *)allDailies;

@end

NS_ASSUME_NONNULL_END
