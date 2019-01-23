//
//  DJTodayFireMainVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJTodayFireMainVC.h"
#import "DJTodayFireVoiceListTVC.h"
#import "DJSessionManager.h"
#import "MJExtension.h"
#import "DJCategoryModel.h"
#import "DJSegmentBar.h"
#import "UIView+DJLayout.h"

#define kBaseUrl @"http://mobile.ximalaya.com/"

@interface DJTodayFireMainVC ()<DJSegmentBarDelegate,UIScrollViewDelegate>

@property (retain, nonatomic)NSArray<DJCategoryModel *> *categoryMs;
@property (retain, nonatomic)DJSessionManager *sessionManager;
@property (retain, nonatomic)DJSegmentBar *segmentBar;
@property (retain, nonatomic)UIScrollView *contentScrollView;

@end

@implementation DJTodayFireMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self loadData];
}

#pragma mark - setter
- (void)setCategoryMs:(NSArray<DJCategoryModel *> *)categoryMs{
    _categoryMs = categoryMs;
    NSInteger vcCount = _categoryMs.count;
    NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:vcCount];
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:vcCount];
    for (DJCategoryModel *model in _categoryMs) {
        DJTodayFireVoiceListTVC *vc = [[DJTodayFireVoiceListTVC alloc] init];
        vc.loadKey = model.key;
        [vcs addObject:vc];
        [titleArr addObject:model.name];
        [self addChildViewController:vc];
    }
    self.segmentBar.segmentMs = titleArr;
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width * self.childViewControllers.count, 0);
}

#pragma mark - 私有方法
- (void)loadData{
    __weak typeof (self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{@"device": @"iPhone",
                            @"key": @"ranking:track:scoreByTime:1:0",
                            @"pageId": @"1",
                            @"pageSize": @"0"};
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        DJCategoryModel *categoryM = [[DJCategoryModel alloc] init];
        categoryM.key = @"ranking:track:scoreByTime:1:0";
        categoryM.name = @"总榜";
        NSMutableArray <DJCategoryModel *>*categoryMs = [DJCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"categories"]];
        if (categoryMs.count > 0) {
            [categoryMs insertObject:categoryM atIndex:0];
        }
        weakSelf.categoryMs = categoryMs;
    }];
}

- (void)setupUI{
    self.title = @"今日最火";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.segmentBar];
    [self.segmentBar updateWithConfig:^(DJSegmentBarConfig * _Nonnull config) {
        config.isShowMore = YES;
    }];
    [self.view addSubview:self.contentScrollView];
}

- (void)showControllerView:(NSInteger)index {
    UIView *view = self.childViewControllers[index].view;
    CGFloat contentViewW = self.contentScrollView.frame.size.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];
}

#pragma mark -Delegate
- (void)segmentBar:(DJSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    
    [self showControllerView:toIndex];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentBar.selectIndex = page;
}

#pragma mark - 懒加载

- (DJSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [[DJSessionManager alloc] init];
    }
    return _sessionManager;
}

- (DJSegmentBar *)segmentBar{
    if (!_segmentBar) {
        _segmentBar = [DJSegmentBar segmentBarWithConfig:[DJSegmentBarConfig defaultConfig]];
        _segmentBar.frame = CGRectMake(0, 60, kScreenWidth, 40);
        _segmentBar.backgroundColor = [UIColor whiteColor];
        self.segmentBar.delegate = self;
    }
    return _segmentBar;
}

-(UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarMaxY + self.segmentBar.height, kScreenWidth, kScreenHeight - (kNavigationBarMaxY + self.segmentBar.height))];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
        _contentScrollView = scrollView;
    }
    return _contentScrollView;
}
@end
