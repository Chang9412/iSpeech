//
//  BYPlayer.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/11.
//

#import "BYPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface BYPlayer ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BYPlayer

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)playUrl:(NSURL *)url {
    if (self.player) {
        [self.player stop];
        self.player.delegate = nil;
        self.player = nil;
    }
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        if ([self.delegate respondsToSelector:@selector(playerError:)]) {
            [self.delegate playerError:error];
        }
        return;
    }
    [self.player prepareToPlay];
    [self.player play];
    
    self.timer.fireDate = [NSDate date];
}

- (void)play {
    [self.player play];
}

- (void)replay {
    [self.player playAtTime:0];
}

- (void)pause {
    [self.player pause];
}

- (void)resume {
    [self.player play];
}

- (void)stop {
    [self.player stop];
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if ([self.delegate respondsToSelector:@selector(playerDidReachEnd:)]) {
        [self.delegate playerDidReachEnd:self];
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(playerError:)]) {
        [self.delegate playerError:error];
    }
}

//- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
//
//}
//
//- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player {
//
//}

- (void)updatePlayerTime{
    NSTimeInterval time = [self.player currentTime];
    NSTimeInterval duration = [self.player duration];
    if ([self.delegate respondsToSelector:@selector(playerUpdateTime:duration:)]) {
        [self.delegate playerUpdateTime:time duration:duration];
    }
}

- (NSTimer *)timer {
    if (_timer) {
        return _timer;
    }
    BYWeak(self)
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        BYStrong(self)
        [self updatePlayerTime];
    }];
    _timer.fireDate = [NSDate distantFuture];
    return _timer;
}
@end
