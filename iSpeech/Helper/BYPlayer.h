//
//  BYPlayer.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class  BYPlayer;
@protocol BYPlayerDelegate <NSObject>

- (void)playerReadyToPlay:(BYPlayer *)player;
- (void)player:(BYPlayer *)player updateMeters:(NSArray *)channels;
- (void)playerDidReachEnd:(BYPlayer *)player;
- (void)playerError:(NSError *)error;
- (void)playerUpdateTime:(NSTimeInterval)time duration:(NSTimeInterval)duration;


@end

@interface BYPlayer : NSObject

@property (nonatomic, weak) id<BYPlayerDelegate> delegate;

- (void)playUrl:(NSURL *)url;

- (void)play;
- (void)replay;
- (void)pause;
- (void)resume;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
