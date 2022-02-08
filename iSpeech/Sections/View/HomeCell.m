//
//  HomeCell.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import "HomeCell.h"
#import <Masonry.h>
#import "IPBanner.h"

@interface HomeCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation HomeCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];

    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (UIView *)backView {
    if (_backView) {
        return _backView;
    }
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor colorWithRGB:0xe8e8e8];
    _backView.clipsToBounds = YES;
    _backView.layer.cornerRadius = 10;
    return _backView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorWithRGB:0x333333];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (_dateLabel) {
        return _dateLabel;
    }
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.textColor = [UIColor colorWithRGB:0x666666];
    return _dateLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel) {
        return _contentLabel;
    }
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textColor = [UIColor colorWithRGB:0x333333];
    return _contentLabel;
}


@end

@interface HomeCell1 ()

@property (nonatomic, strong) IPBanner *banerView;

@end

@implementation HomeCell1

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.banerView];
    [self.banerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setBanner:(NSArray *)banner {
    self.banerView.banners = banner;
}

- (IPBanner *)banerView {
    if (_banerView) {
        return _banerView;
    }
    _banerView = [[IPBanner alloc] init];
    
    return _banerView;
}

@end

@interface HomeCell2 ()

@property (nonatomic, strong) UIButton *recorderButton;
@property (nonatomic, strong) UIButton *inputButton;
@property (nonatomic, strong) UIButton *translateButton;

@end

@implementation HomeCell2

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.recorderButton];
    [self.contentView addSubview:self.inputButton];
    [self.contentView addSubview:self.translateButton];
    
    [self.recorderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@12);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.45);
        make.height.equalTo(self.recorderButton.mas_width);
    }];
    
    [self.inputButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recorderButton.mas_right).offset(12);
        make.top.equalTo(self.recorderButton);
        make.bottom.equalTo(self.recorderButton.mas_centerY).offset(-6);
        make.right.equalTo(@-12);
    }];
    
    [self.translateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.inputButton);
        make.top.equalTo(self.inputButton.mas_bottom).offset(12);
    }];
}

- (void)recorderButtonClicked {
    self.didSelectOpration(IPOperationTypeRecorder);
}

- (void)inputButtonClicked {
    self.didSelectOpration(IPOperationTypeInput);
}

- (void)translateButtonClicked {
    self.didSelectOpration(IPOperationTypeTextToAudio);
}


- (UIButton *)recorderButton {
    if (_recorderButton) {
        return _recorderButton;
    }
    _recorderButton = [[UIButton alloc] init];
    [_recorderButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_recorderButton addTarget:self action:@selector(recorderButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_recorderButton setBackgroundColor:[UIColor random]];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@""];
    [_recorderButton addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.recorderButton);
        make.bottom.equalTo(self.recorderButton.mas_centerY).offset(-20);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"开始录音";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    [_recorderButton addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.recorderButton);
        make.top.equalTo(imageView.mas_bottom).offset(10);
    }];
    return _recorderButton;
}

- (UIButton *)inputButton {
    if (_inputButton) {
        return _inputButton;
    }
    _inputButton = [[UIButton alloc] init];
    [_inputButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_inputButton addTarget:self action:@selector(inputButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_inputButton setBackgroundColor:[UIColor random]];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@""];
    [_inputButton addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inputButton);
        make.left.equalTo(@20);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"从外部导入";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    [_inputButton addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inputButton);
        make.left.equalTo(imageView.mas_right).offset(10);
    }];
    return _inputButton;
}

- (UIButton *)translateButton {
    if (_translateButton) {
        return _translateButton;
    }
    _translateButton = [[UIButton alloc] init];
    [_translateButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_translateButton addTarget:self action:@selector(inputButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_translateButton setBackgroundColor:[UIColor random]];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@""];
    [_translateButton addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.translateButton);
        make.left.equalTo(@20);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"文字转语音";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    [_translateButton addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.translateButton);
        make.left.equalTo(imageView.mas_right).offset(10);
    }];
    return _translateButton;
}


@end

@interface HomeCell3 ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
    
@end

@implementation HomeCell3

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(@10);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
    }];
    [self.imageView setBackgroundColor:[UIColor random]];

}

- (void)setOperation:(IPOperation *)operation {
    self.imageView.image = [UIImage imageNamed:@""];
    self.label.text = operation.title;
}

- (UIImageView *)imageView {
    if (_imageView ) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    return _imageView;
}

- (UILabel *)label {
    if (_label) {
        return _label;
    }
    _label = [[UILabel alloc] init];
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textAlignment = NSTextAlignmentCenter;
    return _label;
}

@end

@implementation HomeBaseCell



@end
