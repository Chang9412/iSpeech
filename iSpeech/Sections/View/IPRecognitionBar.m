//
//  IPRecognitionBar.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/2/9.
//

#import "IPRecognitionBar.h"
#import <Masonry.h>


@interface IPRecognitionBarCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation IPRecognitionBarCell

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
        make.top.equalTo(@10);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.height.greaterThanOrEqualTo(@0);
    }];
}

- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] init];
    return _imageView;
}

- (UILabel *)label {
    if (_label) {
        return _label;
    }
    _label = [[UILabel alloc] init];
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:13];
    _label.textAlignment = NSTextAlignmentCenter;
    return _label;
}


@end

@interface IPRecognitionBar ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *items;

@end

@implementation IPRecognitionBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.items = @[@"1", @"2", @"3", @"4"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IPRecognitionBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IPRecognitionBarCell" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        cell.label.text = @"";
        cell.imageView.image = [UIImage imageNamed:@""];
    } else if (indexPath.row == 1) {
        cell.label.text = @"";
        cell.imageView.image = [UIImage imageNamed:@""];
    } else if (indexPath.row == 2) {
        cell.label.text = @"";
        cell.imageView.image = [UIImage imageNamed:@""];
    } else if (indexPath.row == 3) {
        cell.label.text = @"";
        cell.imageView.image = [UIImage imageNamed:@""];
    }
    return cell;
}

- (UICollectionView *)collectionView {
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[IPRecognitionBarCell class] forCellWithReuseIdentifier:@"IPRecognitionBarCell"];
    return _collectionView;
}

@end
