//
//  BYRecorder.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import "BYRecorder.h"
#import <AVFoundation/AVFoundation.h>
#import <FCFileManager.h>

@interface BYRecorder ()<AVAudioRecorderDelegate>

//@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BYRecorder

+ (void)initialize {
    [self createDirectoryIfNeed];
}



- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

+ (void)createDirectoryIfNeed {
    NSString *path = [BYRecorder fileDirectory];
    if (![FCFileManager isDirectoryItemAtPath:path]) {
        [FCFileManager createDirectoriesForPath:path];
    }
}

- (void)start {
    if (self.recorder) {
        [self.recorder stop];
        self.recorder = nil;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];

    NSURL *url = [NSURL fileURLWithPath:[self filePath]];
    NSError *error = nil;
    self.state = BYRecorderStateInit;
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url settings:[self recorderSettings] error:&error];
    if (error) {
        self.state = BYRecorderStateError;
        return;
    }
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    self.recorder = recorder;
    [self _start];
}

- (void)_start {
    [self.recorder record];
    self.state = BYRecorderStateRecording;
    [self.timer setFireDate:[NSDate date]];
}

- (void)pause {
    if (!self.recorder) {
        return;
    }
    [self.recorder pause];
    self.state = BYRecorderStatePause;
    [self.timer setFireDate:[NSDate distantFuture]];

}

- (void)resume {
    if (!self.recorder || self.recorder.recording) {
        return;
    }
    if (self.state != BYRecorderStatePause) {
        return;
    }
    [self.recorder record];
    [self.timer setFireDate:[NSDate date]];
}

- (void)stop {
    if (!self.recorder) {
        return;
    }
    [self.recorder stop];
    self.state = BYRecorderStateStop;
}

- (NSURL *)url {
    return self.recorder.url;
}

#pragma mark -

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    self.state = BYRecorderStateComplete;
    if ([self.delegate respondsToSelector:@selector(recorderDidEnd:)]) {
        [self.delegate recorderDidEnd:self];
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    if (error) {
        self.state = BYRecorderStateError;
        if ([self.delegate respondsToSelector:@selector(recorderError:)]) {
            [self.delegate recorderError:error];
        }
    }
    
}

- (void)updateMeters {
    [self.recorder updateMeters];
    float power0 = [self.recorder averagePowerForChannel:0];
    float power1 = [self.recorder peakPowerForChannel:0];

    NSLog(@"%f %f", power0, power1);
    
    if ([self.delegate respondsToSelector:@selector(recorderUpdateMeters:)]) {
        [self.delegate recorderUpdateMeters:@[@(power0), @(power1)]];
    }
}

#pragma mark -

//- (AVAudioSession *)session {
//    if (_session) {
//        return _session;
//    }
//    _session = [AVAudioSession sharedInstance];
//    [_session setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSessionModeVideoRecording options:AVAudioSessionCategoryOptionDuckOthers error:nil];
//    [_session setActive:YES error:nil];
//
//    return _session;
//}

+ (NSString *)fileDirectory {
    return [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/Audio"];;
}

- (NSString *)filePath {
    static NSDateFormatter *formatter;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
//        formatter.dateStyle = NSDateFormatterLongStyle;
    }
    NSString *fileName = [NSString stringWithFormat:@"%@.wav", [formatter stringFromDate:[NSDate date]]];
    return [[BYRecorder fileDirectory] stringByAppendingPathComponent:fileName];
}

- (NSDictionary *)recorderSettings {
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
   
//    [settings setObject:@(kAudioFormatAppleIMA4) forKey:AVFormatIDKey];
    //音频质量,采样质量
    [settings setObject:@(AVAudioQualityMax) forKey:AVEncoderAudioQualityKey];
    //通道数 编码时每个通道的比特率
    [settings setObject:@(1) forKey:AVNumberOfChannelsKey];
    //采样率
    [settings setObject:@(44100.0) forKey:AVSampleRateKey];
    //线性采样位数
    [settings setObject:@(32) forKey:AVLinearPCMBitDepthKey];
    // 编码时的比特率，是每秒传送的比特(bit)数单位为bps(Bit Per Second)，比特率越高传送数据速度越快值是一个整数
    [settings setObject:@(128000) forKey:AVEncoderBitRateKey];
    return settings;
}

- (NSTimer *)timer {
    if (_timer) {
        return _timer;
    }
    BYWeak(self)
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        BYStrong(self)
        [self updateMeters];
    }];
    [_timer setFireDate:[NSDate distantFuture]];
    return _timer;
}

@end
