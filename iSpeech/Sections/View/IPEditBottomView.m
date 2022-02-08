//
//  IPEditView.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import "IPEditBottomView.h"
#import <Masonry.h>

@interface IPEditBottomView ()

@property (nonatomic, strong) UIButton *selectAllButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation IPEditBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.selectAllButton];
    [self addSubview:self.deleteButton];
    [self addSubview:self.lineView];
    
    [self.selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.height.equalTo(@49);
        make.right.equalTo(self.mas_centerX);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.height.equalTo(self.selectAllButton);
        make.left.equalTo(self.selectAllButton.mas_right);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectAllButton);
        make.centerX.equalTo(self);
        make.width.equalTo(@1);
        make.height.equalTo(@36);
    }];
}

- (void)selectAllButtonClicked {
    self.selectAllButton.selected = !self.selectAllButton.selected;
    if (self.selectAllBlock) {
        self.selectAllBlock(self.selectAllButton.selected);
    }
}

- (void)deleteButtonClicked {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

- (void)selectAll:(BOOL)select {
    self.selectAllButton.selected = select;
}

- (void)enableDelete:(BOOL)enable {
    self.deleteButton.enabled = enable;
}

- (UIButton *)selectAllButton {
    if (_selectAllButton) {
        return _selectAllButton;
    }
    _selectAllButton = [[UIButton alloc] init];
    [_selectAllButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    [_selectAllButton setTitleColor:[UIColor colorWithRGB:0x333333] forState:UIControlStateNormal];
    [_selectAllButton setTitleColor:[UIColor theme] forState:UIControlStateSelected];
    _selectAllButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _selectAllButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    _selectAllButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_selectAllButton addTarget:self action:@selector(selectAllButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _selectAllButton;;
}

- (UIButton *)deleteButton {
    if (_deleteButton) {
        return _deleteButton;
    }
    _deleteButton = [[UIButton alloc] init];
    [_deleteButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor colorWithRGB:0x999999] forState:UIControlStateDisabled];
    [_deleteButton setTitleColor:[UIColor theme] forState:UIControlStateSelected];
    _deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _deleteButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    _deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _deleteButton.enabled = NO;
    return _deleteButton;;
}

@end
