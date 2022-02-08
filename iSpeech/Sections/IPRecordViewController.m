//
//  IPRecordViewController.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/4.
//

#import "IPRecordViewController.h"
#import "BYRecorder.h"
#import "BYPlayer.h"
#import "BYRecognizer.h"
#import <Masonry.h>
#import <ReactiveCocoa.h>
#import <MBProgressHUD.h>
#import "IPMetersView.h"

@interface IPRecordViewController ()<BYRecorderDelegate, BYPlayerDelegate, BYRecognizerDelegate>

@property (nonatomic, assign) IPRecordViewControllerStyle style;
@property (nonatomic, strong) NSURL *fileUrl;

@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) BYRecorder *recorder;

@property (nonatomic, strong) IPMetersView *metersView;

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) BYPlayer *player;

@property (nonatomic, strong) BYRecognizer *recognizer;

@end

@implementation IPRecordViewController

- (instancetype)initWithStyle:(IPRecordViewControllerStyle)style url:(NSURL *)url {
    if (self = [super init]) {
        _style = style;
        _fileUrl = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    if (self.style == IPRecordViewControllerStyleRecorder) {
        self.title = @"录音";
        [self.view addSubview:self.recordButton];
        [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-80);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        [self.view addSubview:self.metersView];
        [self.metersView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
            make.bottom.equalTo(self.recordButton.mas_top).offset(-50);
            make.height.equalTo(@60);
        }];
        [self initRecorder];
    } else {
        self.title = @"识别语音";
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.playButton];
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-80);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        [self.view addSubview:self.metersView];
        [self.metersView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
            make.bottom.equalTo(self.playButton.mas_top).offset(-50);
            make.height.equalTo(@60);
        }];
        [self initPlayer];
        
    }
    [self initRecognizer];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)test {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"示例音频" withExtension:@"mp3"];
    [self.recognizer recognitionWithUrl:url];
}

- (void)showMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:1];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}


- (void)recordButtonClicked {
    if (self.recorder.state == BYRecorderStatePause) {
        [self.recorder resume];
    } else if (self.recorder.state == BYRecorderStateRecording) {
        [self.recorder pause];
        [self.recordButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    } else {
        [self.recorder start];
        [self.recordButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    }
}



- (void)initRecorder {
    BYRecorder *recorder = [[BYRecorder alloc] init];
    recorder.delegate = self;
    self.recorder = recorder;
    
}

- (void)initPlayer {
    BYPlayer *player = [[BYPlayer alloc] init];
    player.delegate = self;
    [player playUrl:self.fileUrl];
    self.player = player;
}

- (void)initRecognizer {
    BYRecognizer *recognizer = [[BYRecognizer alloc] init];
    recognizer.delegate = self;
    if (self.style == IPRecordViewControllerStyleRecorder) {
        
    } else {
        [recognizer recognitionWithUrl:self.fileUrl];
    }
    self.recognizer = recognizer;
}

#pragma mark - recognizer

- (void)recognizerError:(NSError *)error {
    
}

#pragma mark - recorder

- (void)recorderDidStart:(BYRecorder *)recorder {
    [self.recognizer recognitionWithUrl:recorder.url];
}

- (void)recorderUpdateMeters:(NSArray *)channels {
    [self.metersView updateMeters:channels];
}

- (void)recorderDidEnd:(BYRecorder *)recorder {
    
}

- (void)recorderError:(NSError *)error {
    
}

#pragma mark - player

- (void)playerReadyToPlay:(BYPlayer *)player {
    
}

- (void)playerDidReachEnd:(BYPlayer *)player {
    
}

- (void)playerError:(NSError *)error {
    
}

- (void)playerUpdateTime:(NSTimeInterval)time duration:(NSTimeInterval)duration {
    
}

- (void)player:(BYPlayer *)player updateMeters:(NSArray *)channels {
    [self.metersView updateMeters:channels];
}

#pragma mark -

- (UIButton *)recordButton {
    if (_recordButton) {
        return _recordButton;
    }
    _recordButton = [[UIButton alloc] init];
    [_recordButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
//    [_recordButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    _recordButton.backgroundColor = [UIColor theme];
    _recordButton.clipsToBounds = YES;
    _recordButton.layer.cornerRadius = 30;
    [_recordButton addTarget:self action:@selector(recordButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _recordButton;
}

- (UIButton *)playButton {
    if (_playButton) {
        return _playButton;
    }
    _playButton = [[UIButton alloc] init];
    [_playButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    _playButton.backgroundColor = [UIColor theme];
    _playButton.clipsToBounds = YES;
    _playButton.layer.cornerRadius = 30;
    [_playButton addTarget:self action:@selector(recordButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _playButton;
}

- (IPMetersView *)metersView {
    if (_metersView) {
        return _metersView;
    }
    _metersView = [[IPMetersView alloc] init];
    
    return _metersView;
}
- (void)dealloc {
    if (self.recorder) {
        [self.recorder stop];
    }
}

@end
