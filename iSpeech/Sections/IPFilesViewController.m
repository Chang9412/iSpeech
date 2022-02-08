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

- (IPEditTableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[IPEditTableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 52;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[IPFilesCell class] forCellReuseIdentifier:@"IPFilesCell"];
    return _tableView;
}
@end
