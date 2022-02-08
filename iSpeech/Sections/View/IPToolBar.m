//
//  IPToolBar.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import "IPToolBar.h"
#import <Masonry.h>

@interface IPToolBar ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *recognizerButton;
@property (nonatomic, strong) UIButton *recorderButton;
@property (nonatomic, strong) UIButton *filesButton;

@end

@implementation IPToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.backgroundView];
    [self addSubview:self.recorderButton];
    [self addSubview:self.recognizerButton];
    [self addSubview:self.filesButton];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    [self.recorderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    [self.recognizerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.equalTo(self.recorderButton);
        make.left.equalTo(@10);
    }];
    [self.filesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.equalTo(self.recorderButton);
        make.right.equalTo(@-10);
    }];
}

- (void)recognizerButtonClicked {
    if (self.didSelected) {
        self.didSelected(0);
    }
}

- (void)recorderButtonClicked {
    if (self.didSelected) {
        self.didSelected(1);
    }
}

- (void)filesButtonClicked {
    if (self.didSelected) {
        self.didSelected(2);
    }
}

- (UIButton *)recognizerButton {
    if (_recognizerButton) {
        return _recognizerButton;
    }
    _recognizerButton = [[UIButton alloc] init];
    [_recognizerButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    UILabel *label = [[UILabel alloc] init];
    [_recognizerButton addSubview:label];
    label.text = @"识别";
    label.textColor = [UIColor colorWithRGB:0x666666];
    label.font = [UIFont systemFontOfSize:13];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.recognizerButton);
        make.centerY.equalTo(self.recognizerButton.mas_centerY).offset(30);
    }];
    [_recognizerButton addTarget:self action:@selector(recognizerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _recognizerButton;
}


- (UIButton *)filesButton {
    if (_filesButton) {
        return _filesButton;
    }
    _filesButton = [[UIButton alloc] init];
    [_filesButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    UILabel *label = [[UILabel alloc] init];
    [_filesButton addSubview:label];
    label.text = @"文件库";
    label.textColor = [UIColor colorWithRGB:0x666666];
    label.font = [UIFont systemFontOfSize:13];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.filesButton);
        make.centerY.equalTo(self.filesButton.mas_centerY).offset(30);
    }];
    [_filesButton addTarget:self action:@selector(filesButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _filesButton;
}

- (UIButton *)recorderButton {
    if (_recorderButton) {
        return _recorderButton;
    }
    _recorderButton = [[UIButton alloc] init];
    [_recorderButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_recorderButton addTarget:self action:@selector(recorderButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _recorderButton;
}

- (UIView *)backgroundView {
    if (_backgroundView) {
        return _backgroundView;
    }
    _backgroundView = [[UIView alloc] init];
    _backgroundView.layer.cornerRadius = 30;
    _backgroundView.backgroundColor = [UIColor colorWithRGB:0xf1f1f1];
    return _backgroundView;
}

@end
