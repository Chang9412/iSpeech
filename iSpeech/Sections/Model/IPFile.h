//
//  IPFile.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPFile : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) NSInteger filesize;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSString *createDateString;

@end

NS_ASSUME_NONNULL_END
