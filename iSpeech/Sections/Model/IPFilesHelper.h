//
//  IPFilesHelper.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import <Foundation/Foundation.h>
#import "IPFile.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IPFilesSortType) {
    IPFilesSortTypeCreateTime,
    IPFilesSortTypeCreateTime2,
    IPFilesSortTypeFileSize,
    IPFilesSortTypeFileSize2,
};

@interface IPFilesHelper : NSObject

+ (NSArray *)allFiles;
+ (NSArray *)allFilesSorted:(IPFilesSortType)type;

+ (BOOL)deleteFileAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
