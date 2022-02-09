//
//  IPFilesViewController.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import "IPFilesViewController.h"
#import "IPFilesHelper.h"
#import <Masonry.h>
#import "IPEditTableView.h"
#import "IPFilesCell.h"
#import "IPInputFileViewController.h"
#import "IPRecognizerHelper.h"

@interface IPFilesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IPEditTableView *tableView;
@property (nonatomic, strong) NSArray *files;

@end

@implementation IPFilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.files = [IPFilesHelper allFiles];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(onManage)];
}

- (void)onManage {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.files.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IPFilesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IPFilesCell" forIndexPath:indexPath];
    cell.file = self.files[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IPFile *file = self.files[indexPath.row];
    [IPRecognizerHelper openRecognizerViewControllerWithUrl:[NSURL fileURLWithPath:file.path]];
}

- (IPEditTableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[IPEditTableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 52;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[IPFilesCell class] forCellReuseIdentifier:@"IPFilesCell"];
    return _tableView;
}
@end
