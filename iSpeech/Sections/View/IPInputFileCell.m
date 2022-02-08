//
//  IPInputFileCell.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/6.
//

#import "IPInputFileCell.h"
#import <Masonry.h>

@interface IPInputFileCell ()

@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;

@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *inputButton;

@end

@implementation IPInputFileCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.backView1];
    [self.backView1 addSubview:self.label1];
    [self.backView1 addSubview:self.label2];
    [self.backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@12);
        make.right.equalTo(@-12);
        make.height.equalTo(@60);
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@10);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.bottom.equalTo(@-12);
    }];
    
    
    [self.contentView addSubview:self.backView2];
    [self.backView2 addSubview:self.lineView];
    [self.backView2 addSubview:self.titleLabel];
    [self.backView2 addSubview:self.inputButton];
    [self.backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(self.backView1.mas_bottom).offset(10);
        make.right.equalTo(@-12);
        make.height.equalTo(@100);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@10);
        make.width.equalTo(@3);
        make.height.equalTo(@12);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(5);
        make.centerY.equalTo(self.lineView);
    }];
    [self.inputButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(20);
        make.centerX.equalTo(self.backView2);
        make.width.equalTo(@300);
        make.height.equalTo(@40);
    }];
}

- (void)inputButtonClicked {
    if (self.inputBlock) {
        self.inputBlock();
    }
}


- (UIView *)backView1 {
    if (_backView1) {
        return _backView1;
    }
    _backView1 = [[UIView alloc] init];
    _backView1.backgroundColor = [UIColor whiteColor];
    _backView1.clipsToBounds = YES;
    _backView1.layer.cornerRadius = 5;
    return _backView1;
}

- (UILabel *)label1 {
    if (_label1) {
        return _label1;
    }
    _label1 = [[UILabel alloc] init];
    _label1.text = @"目前支持的音频格式有mp3、wav、m4a";
    _label1.font = [UIFont systemFontOfSize:13];
    _label1.textColor = [UIColor colorWithRGB:0x666666];
    return _label1;
}

- (UILabel *)label2 {
    if (_label2) {
        return _label2;
    }
    _label2 = [[UILabel alloc] init];
    _label2.text = @"目前支持的文件时长不超过5小时，大小不超过512M";
    _label2.font = [UIFont systemFontOfSize:13];
    _label2.textColor = [UIColor colorWithRGB:0x666666];
    return _label2;
}

- (UIView *)backView2 {
    if (_backView2) {
        return _backView2;
    }
    _backView2 = [[UIView alloc] init];
    _backView2.backgroundColor = [UIColor whiteColor];
    _backView2.clipsToBounds = YES;
    _backView2.layer.cornerRadius = 5;
    return _backView2;
}

- (UIView *)lineView {
    if (_lineView) {
        return _lineView;
    }
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor theme];
    return _lineView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"方式1：本地文件可直接导入";
    return _titleLabel;
}

- (UIButton *)inputButton {
    if (_inputButton) {
        return _inputButton;
    }
    _inputButton = [[UIButton alloc] init];
    [_inputButton setTitle:@"开始导入文件" forState:UIControlStateNormal];
    [_inputButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _inputButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _inputButton.clipsToBounds = YES;
    _inputButton.layer.cornerRadius = 20;
    _inputButton.backgroundColor = [UIColor theme];
    [_inputButton addTarget:self action:@selector(inputButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _inputButton;
}

@end



@interface IPInputFileCell2 ()

@end

@implementation IPInputFileCell2

@end
