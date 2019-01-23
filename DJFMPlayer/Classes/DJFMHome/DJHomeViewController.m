//
//  DJHomeViewController.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/18.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJHomeViewController.h"
#import "DJSegmentBar.h"
#import "DJFMHomeDataTool.h"
#import "DJRecommendTVC.h"
#import "DJClassificationTVC.h"
#import "DJRadioBroadcaseTVC.h"
#import "DJBillBoardTVC.h"
#import "DJFMAnchorTVC.h"


@interface DJHomeViewController ()<DJSegmentBarDelegate,UIScrollViewDelegate>
/**
 可以通过这个属性配置相关参数, 比如位置, 是否显示更多, 默认索引等
 */
@property (nonatomic, weak, readonly) DJSegmentBar *segmentBar;

@property (nonatomic, weak) UIScrollView *contentScrollView;
@end

@implementation DJHomeViewController

@synthesize segmentBar = _segmentBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发现";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segBarFrame = CGRectMake(0, kNavigationBarMaxY, kScreenWidth, kMenueBarHeight);
    self.contentScrollViewFrame = CGRectMake(0, kNavigationBarMaxY + kMenueBarHeight, kScreenWidth, kScreenHeight - kNavigationBarMaxY - kTabbarHeight - kMenueBarHeight);
    
    [[DJFMHomeDataTool shareInstance] getHomeTabs:^(NSArray * _Nonnull tabMs) {
        [self setUpWithSegModels:tabMs andChildVCs:@[[DJRecommendTVC new],[DJClassificationTVC new],[DJRadioBroadcaseTVC new],[DJBillBoardTVC new],[DJFMAnchorTVC new]]];
        self.segSelectIndex = 0;
    }];
    
}



#pragma mark - setter
- (void)setContentScrollViewFrame:(CGRect)contentScrollViewFrame{
    _contentScrollViewFrame = contentScrollViewFrame;
    self.contentScrollView.frame = _contentScrollViewFrame;
}

- (void)setSegBarFrame:(CGRect)segBarFrame{
    _segBarFrame = segBarFrame;
    self.segmentBar.frame = segBarFrame;
}

- (void)setSegSelectIndex:(NSInteger)segSelectIndex{
     self.segmentBar.selectIndex = segSelectIndex;
}

#pragma mark - 私有方法
- (void)setUpWithSegModels:(NSArray<id<DJSegmentModelProtocol>> *)segMs andChildVCs:(NSArray *)subVCs{
    // 0. 添加子控制器
    for (UIViewController *vc in subVCs) {
        [self addChildViewController:vc];
    }
    
    self.segmentBar.segmentMs = segMs;
    // 1. 设置菜单栏
    [self.view addSubview:self.segmentBar];
    
    // 2. 设置代理
    self.segmentBar.delegate = self;
    
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width * self.childViewControllers.count, 0);
}

- (void)showControllerView:(NSInteger)index {
    UIView *view = self.childViewControllers[index].view;
    CGFloat contentViewW = self.contentScrollView.frame.size.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];
}

#pragma mark - delegate
- (void)segmentBar:(DJSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    [self showControllerView:toIndex];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentBar.selectIndex = page;
    
}

#pragma mark - 懒加载
- (DJSegmentBar *)segmentBar{
    if (!_segmentBar) {
        DJSegmentBar *segmentBar = [DJSegmentBar segmentBarWithConfig:[DJSegmentBarConfig defaultConfig]];
        _segmentBar.backgroundColor = [UIColor yellowColor];
        _segmentBar.frame = self.segBarFrame;
        _segmentBar = segmentBar;
        [_segmentBar updateWithConfig:^(DJSegmentBarConfig * _Nonnull config) {
            
        }];
        [self.view addSubview:_segmentBar];
    }
    return _segmentBar;
}

-(UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        // 2. 添加内容视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.contentScrollViewFrame];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        _contentScrollView = scrollView;
        [self.view addSubview:scrollView];
    }
    return _contentScrollView;
}


@end
