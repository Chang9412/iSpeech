//
//  IPDBHelper.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPDBHelper : NSObject

+ (void)batchUpdateDailies:(NSArray *)dailies;
+ (void)deleteDailies:(NSArray *)dailies;
+ (NSArray *)allDailies;

@end

NS_ASSUME_NONNULL_END
