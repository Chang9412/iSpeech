//
//  IPFilesCell.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import "IPFilesCell.h"
#import <Masonry.h>

@interface IPFilesCell ()

@property (nonatomic, strong) UIImageView *playImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UIButton *moreButton;

@end

@implementation IPFilesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;;
}

- (void)setup {
    [self.contentView addSubview:self.playImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.introLabel];
    [self.contentView addSubview:self.moreButton];
    
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playImageView.mas_right).offset(12);
        make.right.equalTo(@-80);
        make.top.equalTo(self.playImageView.mas_top).offset(-5);
        make.height.greaterThanOrEqualTo(@0);
    }];
    [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.greaterThanOrEqualTo(@0);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.contentView);
        make.width.equalTo(@60);
    }];
}

- (void)setFile:(IPFile *)file {
    
}

- (void)moreButtonClicked {
    
}

- (UIImageView *)playImageView {
    if (_playImageView) {
        return _playImageView;
    }
    _playImageView = [[UIImageView alloc] init];
    _playImageView.image = [UIImage imageNamed:@""];
    return _playImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textColor = [UIColor blackColor];
    return _titleLabel;
}

- (UILabel *)introLabel {
    if (_introLabel) {
        return _introLabel;
    }
    _introLabel = [[UILabel alloc] init];
    _introLabel.textColor = [UIColor colorWithRGB:0x333333];
    _introLabel.font = [UIFont systemFontOfSize:13];
    return _introLabel;
}

- (UIButton *)moreButton {
    if (_moreButton) {
        return _moreButton;
    }
    _moreButton = [[UIButton alloc] init];
    [_moreButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _moreButton;
}

@end
