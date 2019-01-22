//
//  DJDownloadBaseVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJDownloadBaseVC.h"
#import "DJNoDownloadView.h"
#import "DJTodayFireMainVC.h"

@interface DJDownloadBaseVC ()<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic)UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSources;

@property (nonatomic, weak) DJNoDownloadView *noDataLoadView;

@property (nonatomic, copy) GetCellBlock cellBlock;
@property (nonatomic, copy) BindBlock bindBlock;
@end

@implementation DJDownloadBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    self.noDataLoadView.center = CGPointMake(self.view.frame.size.width *0.5, self.view.frame.size.height*0.4);
    if ([self isKindOfClass:NSClassFromString(@"DJDownloadingVoiceVC")]) {
        self.noDataLoadView.noDataImg = [UIImage imageNamed:@"noData_downloading"];
    }else {
        self.noDataLoadView.noDataImg = [UIImage imageNamed:@"noData_download"];
    }
    
    [self.noDataLoadView setClickBlock:^{
        NSLog(@"去看看");
        DJTodayFireMainVC *vc = [[DJTodayFireMainVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - uitableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.noDataLoadView.hidden = self.dataSources.count != 0;
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = self.cellBlock(tableView,indexPath);
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.dataSources[indexPath.row];
    self.bindBlock(cell, model);
}

#pragma mark - 接口
- (void)setUpWithDataSource:(NSArray *)dataSource getCell:(GetCellBlock)cellBlock bind:(BindBlock)bindBlock{
    self.dataSources = dataSource;
    self.cellBlock = cellBlock;
    self.bindBlock = bindBlock;
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = self.view.frame;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (DJNoDownloadView *)noDataLoadView{
    if (!_noDataLoadView) {
        DJNoDownloadView *view = [DJNoDownloadView noDownloadView];
        [self.view addSubview:view];
        _noDataLoadView = view;
    }
    return _noDataLoadView;
}


@end
