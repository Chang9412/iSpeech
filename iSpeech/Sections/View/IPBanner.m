//
//  IPBanner.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/10.
//

#import "IPBanner.h"
#import <Masonry.h>

@interface IPBannerCell: UICollectionViewCell

@property (nonatomic, strong) IPBannerItem *item;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation IPBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor random];

    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.bottom.equalTo(@-20);
        make.right.equalTo(@-20);
    }];
}

- (void)setItem:(IPBannerItem *)item {
    if ([item.image hasPrefix:@"http"]) {
        [self.imageView app_setUrl:item.image];
    } else {
        self.imageView.image = [UIImage imageNamed:item.image];
    }
    self.titleLabel.text = item.title;
}

- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor whiteColor];
    return _titleLabel;
}

@end

@interface IPBanner ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation IPBanner

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setBanners:(NSArray *)banners {
    NSMutableArray *marray = [NSMutableArray arrayWithArray:banners];
    if (marray.count > 0) {
        [marray addObjectsFromArray:banners];
        [marray addObjectsFromArray:banners];
    }
    _banners = marray;
    self.currentIndex = 0;
    [self.collectionView reloadData];
    [self.timer setFireDate:[NSDate distantFuture]];
    if (marray.count > 0) {
        self.currentIndex = banners.count - 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        [self.timer setFireDate:[NSDate date]];
    }
}

- (void)scroll {
    NSInteger toIndex = self.currentIndex + 1;
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if (self.currentIndex == self.banners.count / 3 * 2) {
            self.currentIndex = self.banners.count / 3 - 1;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        } else {
            self.currentIndex = toIndex;
        }
    }];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [CATransaction commit];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.banners.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IPBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IPBannerCell" forIndexPath:indexPath];
    cell.item = self.banners[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectItem) {
        self.didSelectItem(self.banners[indexPath.row]);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (UICollectionView *)collectionView {
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[IPBannerCell class] forCellWithReuseIdentifier:@"IPBannerCell"];
    return _collectionView;
}

- (NSTimer *)timer {
    if (_timer) {
        return _timer;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    return _timer;
}

@end

@implementation IPBannerItem

+ (NSArray *)banners {
    NSMutableArray *marray = [NSMutableArray array];
    {
        IPBannerItem *item = [[IPBannerItem alloc] init];
        item.image = @"";
        item.action = IPBannerActionRecoeder;
        [marray addObject:item];
    }
    {
        IPBannerItem *item = [[IPBannerItem alloc] init];
        item.image = @"";
        item.action = IPBannerActionRecoeder;
        [marray addObject:item];
    }
    {
        IPBannerItem *item = [[IPBannerItem alloc] init];
        item.image = @"";
        item.action = IPBannerActionRecoeder;
        [marray addObject:item];
    }
    {
        IPBannerItem *item = [[IPBannerItem alloc] init];
        item.image = @"";
        item.action = IPBannerActionRecoeder;
        [marray addObject:item];
    }
    return marray;
}

@end
