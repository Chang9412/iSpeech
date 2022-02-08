//
//  ViewController.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/30.
//

#import "ViewController.h"
#import "HomeCell.h"
#import <Masonry.h>
#import <FCFileManager.h>
#import "IPDailyManager.h"
#import "IPRecordViewController.h"
#import "IPTransiaction.h"
#import "IPInputFileViewController.h"
#import "IPOperation.h"
#import "IPBanner.h"
#import "IPRecognizerHelper.h"
#import "IPToolBar.h"
#import "IPFilesViewController.h"
#import "BYRecognizer.h"

#define kBannerSection 0
#define kRecorderSection 1
#define kAudioSection 2

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *recordButton;

@property (nonatomic, strong) IPTransiaction *transiaction;

@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSArray *recorderList;
@property (nonatomic, strong) NSArray *audioList;
@property (nonatomic, strong) IPToolBar *toolBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
}

- (void)setup {
    self.title = @"home";
    self.view.backgroundColor = [UIColor whiteColor];

//    UIBarButtonItem *inputItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(inputFile)];
//    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"write"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewDaily)];
//    self.navigationItem.rightBarButtonItems = @[inputItem, addItem];
    
//    self.transitioningDelegate = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.recordButton];
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-24);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-50);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    [self.view addSubview:self.toolBar];
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@60);
    }];
    
    [self loadData];
}

- (void)loadData {
    self.bannerList = [IPBannerItem banners];
    self.recorderList = [IPOperation operationsForRecorder];
    self.audioList = [IPOperation operationsForAudio];
}

- (void)gotoRecorderViewController {
    [IPRecognizerHelper openRecorderViewController];
}

- (void)gotoFilesViewController {
    IPFilesViewController *vc = [[IPFilesViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoInputFileViewController {
    IPInputFileViewController *vc = [[IPInputFileViewController alloc] init];
    vc.didPickDocument = ^(NSURL * _Nonnull url) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *path = [[BYRecognizer fileDirectory] stringByAppendingPathComponent:url.lastPathComponent];
        BOOL isWrited = [data writeToFile:path atomically:YES];
        if (!isWrited) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"文件写入失败";
            [hud hideAnimated:YES afterDelay:1];
            return;
        }
       
        [IPRecognizerHelper openRecognizerViewControllerWithUrl:[NSURL fileURLWithPath:path]];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectOperation:(IPOperationType)type from:(NSString *)from {
    switch (type) {
        case IPOperationTypeNone:
            
            break;
        case IPOperationTypeRecorder:
            [self gotoRecorderViewController];
            break;
        case IPOperationTypeInput:
            [self gotoInputFileViewController];
            break;
        case IPOperationTypeTextToAudio:
            
            break;
        case IPOperationTypeVideoToAudio:
            
            break;
        case IPOperationTypeVideoToText:
            
            break;
//        case IPOperationType:
//
//            break;
//        case IPOperationType:
//
//            break;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == kBannerSection) {
        return 1;
    }
    if (section == kRecorderSection) {
        return 1;
    }
    if (section == kAudioSection) {
        return 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kBannerSection) {
        HomeCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell1" forIndexPath:indexPath];
        cell.banner = self.bannerList;
        BYWeak(self)
        cell.didSelectOpration = ^(IPOperationType type) {
            BYStrong(self)
            [self didSelectOperation:type from:@"banner"];
        };
        return cell;
    }
    if (indexPath.section == kRecorderSection) {
        HomeCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell2" forIndexPath:indexPath];
        BYWeak(self)
        cell.didSelectOpration = ^(IPOperationType type) {
            BYStrong(self)
            [self didSelectOperation:type from:@"recorder"];
        };
        return cell;
    }
    if (indexPath.section == kAudioSection) {
        HomeCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell3" forIndexPath:indexPath];
        BYWeak(self)
        cell.didSelectOpration = ^(IPOperationType type) {
            BYStrong(self)
            [self didSelectOperation:type from:@"audio"];
        };
        return cell;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kBannerSection) {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 200);
    }
    if (indexPath.section == kRecorderSection) {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 100);
    }
    if (indexPath.section == kAudioSection) {
        CGFloat itemWidth = (CGRectGetWidth(collectionView.bounds) - 60) / 4;
        return CGSizeMake(itemWidth, 50);
    }
    return CGSizeZero;
}

#pragma mark -

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.transiaction;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.transiaction;
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
    [_collectionView registerClass:[HomeCell1 class] forCellWithReuseIdentifier:@"HomeCell1"];
    [_collectionView registerClass:[HomeCell2 class] forCellWithReuseIdentifier:@"HomeCell2"];
    [_collectionView registerClass:[HomeCell3 class] forCellWithReuseIdentifier:@"HomeCell3"];

    return _collectionView;
}

- (IPToolBar *)toolBar {
    if (_toolBar) {
        return _toolBar;
    }
    _toolBar = [[IPToolBar alloc] init];
    BYWeak(self)
    _toolBar.didSelected = ^(NSInteger index) {
        BYStrong(self)
        if (index == 0) {
            [self gotoRecorderViewController];
        } else if (index == 1) {
            [self gotoRecorderViewController];
        } else {
            [self gotoFilesViewController];
        }
    };
    return _toolBar;
}

- (IPTransiaction *)transiaction {
    if (_transiaction) {
        return _transiaction;
    }
    _transiaction = [[IPTransiaction alloc] init];
    return _transiaction;
}

- (BOOL)prefersNavigationBarHidden {
    return YES;
}

@end
