//
//  IPOperation.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IPOperationType) {
    IPOperationTypeNone,
    IPOperationTypeInput,
    IPOperationTypeRecorder,
    IPOperationTypeTextToAudio,
    IPOperationTypeVideoToAudio,
    IPOperationTypeVideoToText,
};

@interface IPOperation : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) IPOperationType type;

+ (NSArray *)operationsForRecorder;
+ (NSArray *)operationsForAudio;

@end

NS_ASSUME_NONNULL_END
