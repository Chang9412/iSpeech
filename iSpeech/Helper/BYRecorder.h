//
//  BYRecorder.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSUInteger, BYRecorderState) {
    BYRecorderStateInit,
    BYRecorderStateRecording,
    BYRecorderStatePause,
    BYRecorderStateStop,
    BYRecorderStateComplete,
    BYRecorderStateError
};

@class  BYRecorder;
@protocol BYRecorderDelegate <NSObject>

- (void)recorderDidStart:(BYRecorder *)recorder;
- (void)recorderUpdateMeters:(NSArray *)channels;
- (void)recorderDidEnd:(BYRecorder *)recorder;
- (void)recorderError:(NSError *)error;


@end

@interface BYRecorder : NSObject

@property (nonatomic, assign) BYRecorderState state;
@property (nonatomic, weak) id<BYRecorderDelegate> delegate;

@property (nonatomic, readonly) NSURL *url;

- (void)start;
- (void)pause;
- (void)resume;
- (void)stop;

+ (NSString *)fileDirectory;

@end

NS_ASSUME_NONNULL_END
