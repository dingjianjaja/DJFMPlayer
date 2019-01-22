//
//  DJTodayFireMainVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJTodayFireMainVC.h"
#import "DJSegmentBarVC.h"
#import "DJTodayFireVoiceListTVC.h"
#import "DJSessionManager.h"
#import "MJExtension.h"
#import "DJCategoryModel.h"

#define kBaseUrl @"http://mobile.ximalaya.com/"

@interface DJTodayFireMainVC ()

@property (weak, nonatomic)DJSegmentBarVC *segContentVC;
@property (retain, nonatomic)NSArray<DJCategoryModel *> *categoryMs;
@property (retain, nonatomic)DJSessionManager *sessionManager;

@end

@implementation DJTodayFireMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self loadData];
}

#pragma mark - setter
- (void)setCategoryMs:(NSArray<DJCategoryModel *> *)categoryMs{
    _categoryMs = categoryMs;
    NSInteger vcCount = _categoryMs.count;
    NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:vcCount];
    for (DJCategoryModel *model in _categoryMs) {
        DJTodayFireVoiceListTVC *vc = [[DJTodayFireVoiceListTVC alloc] init];
        vc.loadKey = model.key;
        [vcs addObject:vc];
    }
    [self.segContentVC setUpWithItems:[categoryMs valueForKeyPath:@"name"] childVCs:vcs];
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
    self.segContentVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.segContentVC.view];
}


#pragma mark - 懒加载
- (DJSegmentBarVC *)segContentVC{
    if (!_segContentVC) {
        DJSegmentBarVC *vc = [[DJSegmentBarVC alloc] init];
        [self addChildViewController:vc];
        _segContentVC = vc;
    }
    return _segContentVC;
}

- (DJSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [[DJSessionManager alloc] init];
    }
    return _sessionManager;
}

@end
