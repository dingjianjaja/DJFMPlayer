//
//  DJDownloaderMainVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJDownloaderMainVC.h"
#import "DJDownloadAlbumVC.h"
#import "DJDownloadVoiceVC.h"
#import "DJDownloadingVoiceVC.h"
#import "DJSegmentBar.h"

@interface DJDownloaderMainVC ()<UIScrollViewDelegate,DJSegmentBarDelegate>

@property (retain, nonatomic)DJSegmentBar *segmentBar;
@property (retain, nonatomic)UIScrollView *contentScrollView;

@end

@implementation DJDownloaderMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    DJDownloadAlbumVC *vc1 = [[DJDownloadAlbumVC alloc] init];
    vc1.view.backgroundColor = [UIColor brownColor];
    DJDownloadVoiceVC *vc2 = [[DJDownloadVoiceVC alloc] init];
    vc2.view.backgroundColor = [UIColor blueColor];
    DJDownloadingVoiceVC *vc3 = [[DJDownloadingVoiceVC alloc] init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    
    [self.view addSubview:self.contentScrollView];
    self.navigationItem.titleView = self.segmentBar;
    
    
}

#pragma mark - 私有方法
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentBar.selectIndex = page;
}

#pragma mark - 懒加载
- (DJSegmentBar *)segmentBar{
    if (!_segmentBar) {
        DJSegmentBar *segmentBar = [DJSegmentBar segmentBarWithConfig:[DJSegmentBarConfig defaultConfig]];
        segmentBar.frame = CGRectMake(0, 0, kScreenWidth, 40);
        segmentBar.segmentMs = @[@"专辑",@"声音",@"下载中"];
        segmentBar.delegate = self;
        segmentBar.selectIndex = 0;
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        UIScrollView *contentV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        contentV.backgroundColor = [UIColor whiteColor];
        contentV.contentSize = CGSizeMake(3 * contentV.frame.size.width, contentV.frame.size.height);
        contentV.pagingEnabled = YES;
        contentV.delegate = self;
        contentV.showsHorizontalScrollIndicator = NO;
        _contentScrollView = contentV;
    }
    return _contentScrollView;
}

@end
