//
//  IPEditTableView.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import "IPEditTableView.h"
#import "IPEditBottomView.h"
#import <Masonry.h>


@interface IPEditTableView ()

@property (nonatomic, strong) IPEditBottomView *bottomView;


@end

@implementation IPEditTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.equalTo(@49);
    }];
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49+self.safeAreaInsets.bottom));
    }];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [UIView animateWithDuration:0.25 animations:^{
        if (editing) {
            self.bottomView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.bottomView.bounds));
        } else {
            self.bottomView.transform = CGAffineTransformIdentity;
        }
    }];
   
}

- (void)selectAll:(BOOL)select {
    [self.bottomView selectAll:select];
}

- (void)enableDelete:(BOOL)enable {
    [self.bottomView enableDelete:enable];
}

- (IPEditBottomView *)bottomView {
    if (_bottomView) {
        return _bottomView;
    }
    _bottomView = [[IPEditBottomView alloc] init];
    BYWeak(self)
    _bottomView.selectAllBlock = ^(BOOL selected) {
        BYStrong(self)
        if (self.selectAllBlock) {
            self.selectAllBlock(selected);
        }
    };
    _bottomView.deleteBlock = ^{
        BYStrong(self)
        if (self.deleteBlock) {
            self.deleteBlock();
        }
    };
    return _bottomView;
}

@end
