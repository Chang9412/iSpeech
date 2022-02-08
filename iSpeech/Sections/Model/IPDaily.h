//
//  IPDaily.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPAudio : NSObject

//@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) float duration;
@property (nonatomic, assign) NSTimeInterval createTime;

//@property (nonatomic, assign) NSInteger dailyId;

+ (instancetype)audioWithDict:(NSDictionary *)dict;

- (NSString *)audioString;

@end

@interface IPDaily : NSObject

@property (nonatomic, assign) NSInteger did;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) IPAudio *audio;

@property (nonatomic, assign) NSTimeInterval createTime;
@property (nonatomic, assign) NSTimeInterval updateTime;

@property (nonatomic, strong) NSString *extra;
+ (instancetype)dailyWithDict:(NSDictionary *)dict;


@end



NS_ASSUME_NONNULL_END
