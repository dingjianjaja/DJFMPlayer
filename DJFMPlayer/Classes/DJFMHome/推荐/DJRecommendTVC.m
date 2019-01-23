//
//  DJRecommendTVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/18.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJRecommendTVC.h"
#import "DJAdLoopView.h"
#import "DJMenuView.h"
#import "UIButton+WebCache.h"
#import "DJRecommendDataTool.h"

@interface DJRecommendTVC ()

@property (nonatomic, strong) DJAdLoopView *adPicView;

@property (nonatomic, strong) DJMenuView *menueView;
@end

@implementation DJRecommendTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XMGColor(225, 225, 225);
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kCommonMargin, 0);

    // 封装图片轮播器
    [self.tableView.tableHeaderView addSubview:self.adPicView];
    self.adPicView.frame = CGRectMake(0, 0, kScreenWidth, 150);
    // 设置菜单栏
    [self.tableView.tableHeaderView addSubview:self.menueView];
    self.menueView.frame = CGRectMake(0, self.adPicView.height, kScreenWidth, 100);
    
    // 加载广告
    kWeakSelf
    [[DJRecommendDataTool shareInstance] getAdList:^(NSArray<DJAdPicModel *> * _Nonnull adMs, NSError * _Nonnull error) {
        for (int i = 0; i < adMs.count; i ++) {
            DJAdPicModel *adM = adMs[i];
            __weak DJAdPicModel *weakAdM = adM;
            weakAdM.clickBlock = ^{
                NSInteger type = weakAdM.focusImageM.type;
                NSInteger albumID = weakAdM.focusImageM.albumId;
                UINavigationController *nav = self.navigationController;
                if (type == 9) {
                    NSLog(@"听单处理");
                }
                if (type == 3) {
                    NSLog(@"播放器界面");
//                    NSString *albumID = [NSString stringWithFormat:@"%zd", weakAdM.focusImageM.trackId];
//                    kPresentToPlayer(albumID)
                }else if (type == 2) {
                    NSLog(@"跳转到专辑详情");
                    // 跳转到专辑详情
//                    UINavigationController *nav = self.navigationController;
//                    NSString *albumIDStr = [NSString stringWithFormat:@"%zd", albumID];
//                    kJumpToAlbumDetail(albumIDStr, nav)
                }else if (type == 4) {
                    
                    // 打开网页
//                    SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:weakAdM.focusImageM.url]];
//                    sfvc.title = @"商城";
//                    [nav pushViewController:sfvc animated:YES];
                }
                
                
            };
        }
        
        weakSelf.adPicView.picModels = adMs;
    }];
    
    // 加载图文菜单
    [[DJRecommendDataTool shareInstance] getPicMenueList:^(NSArray<DJMenuModel *> * _Nonnull menuePicMs, NSError * _Nonnull error) {
        weakSelf.menueView.menueModels = menuePicMs;
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

#pragma mark - lazyloading
- (DJAdLoopView *)adPicView{
    if (!_adPicView) {
        DJAdLoopView *loopView = [DJAdLoopView picViewWithLoadImageBlock:^(UIImageView * _Nonnull imageView, NSURL * _Nonnull url) {
            [imageView sd_setImageWithURL:url completed:nil];
        }];
        _adPicView = loopView;
    }
    return _adPicView;
}

-(DJMenuView *)menueView {
    
    if(_menueView == nil)
    {
        DJMenuView *menueView = [[DJMenuView alloc] initWithFrame:CGRectZero];
        menueView.loadBlock = ^(UIButton *imageBtn, NSURL *url){
            [imageBtn sd_setImageWithURL:url forState:UIControlStateNormal];
        };
        _menueView = menueView;
    }
    return _menueView;
}

@end
