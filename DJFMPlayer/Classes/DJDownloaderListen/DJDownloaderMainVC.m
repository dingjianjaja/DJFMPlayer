//
//  DJDownloaderMainVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJDownloaderMainVC.h"
#import "DJSegmentBarVC.h"
#import "DJDownloadAlbumVC.h"
#import "DJDownloadVoiceVC.h"
#import "DJDownloadingVoiceVC.h"

@interface DJDownloaderMainVC ()

@property (weak, nonatomic)DJSegmentBarVC *segmentBarVC;

@end

@implementation DJDownloaderMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 300, 40);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    
    self.segmentBarVC.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    [self.view addSubview:self.segmentBarVC.view];
    
    DJDownloadAlbumVC *vc1 = [[DJDownloadAlbumVC alloc] init];
    vc1.view.backgroundColor = [UIColor brownColor];
    DJDownloadVoiceVC *vc2 = [[DJDownloadVoiceVC alloc] init];
    vc2.view.backgroundColor = [UIColor blueColor];
    DJDownloadingVoiceVC *vc3 = [[DJDownloadingVoiceVC alloc] init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    vc3.view.backgroundColor = [UIColor cyanColor];
    [self.segmentBarVC setUpWithItems:@[@"专辑", @"声音", @"下载中"] childVCs:@[vc1, vc2, vc3]];
    
    [self.segmentBarVC.segmentBar updateWithConfig:^(DJSegmentBarConfig *config) {
//        config.segmentBarBackColor = [UIColor whiteColor];
    }];
}


#pragma mark - 懒加载
- (DJSegmentBarVC *)segmentBarVC{
    if (!_segmentBarVC) {
        DJSegmentBarVC *segmentBarVC = [[DJSegmentBarVC alloc] init];
        [self addChildViewController:segmentBarVC];
        _segmentBarVC = segmentBarVC;
    }
    return _segmentBarVC;
}

@end
