//
//  IPInputFileViewController.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/6.
//

#import "IPInputFileViewController.h"
#import "UIScrollView+SafeArea.h"
#import "IPInputFileCell.h"
#import <Masonry.h>

@interface IPInputFileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIDocumentBrowserViewControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation IPInputFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"导入文件";
    self.view.backgroundColor = [UIColor colorWithRGB:0xf5f5f5];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)inputFile {
    [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    UIDocumentBrowserViewController *vc = [[UIDocumentBrowserViewController alloc] init];
    vc.delegate = self;
    vc.allowsDocumentCreation = NO;
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"]  style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
//    item.tintColor = [UIColor theme];
//    vc.additionalLeadingNavigationBarButtonItems = @[item];
    [self presentViewController:vc animated:YES completion:^{

    }];
}

- (void)dismiss {
    if (self.presentedViewController) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)documentURLs {
    
    [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [controller dismissViewControllerAnimated:YES completion:^{
        if (documentURLs.count > 0) {
            if (self.didPickDocument) {
                NSURL *url = documentURLs.firstObject;
                bool isAccessing = [url startAccessingSecurityScopedResource];
                if (!isAccessing) {
                    return;
                }
                self.didPickDocument(documentURLs.firstObject);
                [url stopAccessingSecurityScopedResource];
            }
        }
    }];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        IPInputFileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IPInputFileCell" forIndexPath:indexPath];
        BYWeak(self)
        cell.inputBlock = ^{
            BYStrong(self)
            [self inputFile];
        };
        return cell;
    }
    if (indexPath.row == 1) {
        IPInputFileCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IPInputFileCell2" forIndexPath:indexPath];
        
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 200);
    }
    if (indexPath.row == 1) {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 200);
    }
    return CGSizeZero;
}

- (UICollectionView *)collectionView {
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.sa_shouldAdjustSafeArea = YES;
    [_collectionView registerClass:[IPInputFileCell class] forCellWithReuseIdentifier:@"IPInputFileCell"];
    [_collectionView registerClass:[IPInputFileCell2 class] forCellWithReuseIdentifier:@"IPInputFileCell2"];

    return _collectionView;
}

@end
