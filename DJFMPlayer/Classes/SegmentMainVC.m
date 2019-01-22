//
//  SegmentMainVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/15.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "SegmentMainVC.h"
#import "DJSegmentBarVC.h"
#import "TestVC2.h"

@interface SegmentMainVC ()
@property (weak, nonatomic)DJSegmentBarVC *segmentBarVC;
@end

@implementation SegmentMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 300, 40);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    
    self.segmentBarVC.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    [self.view addSubview:self.segmentBarVC.view];
    
    TestVC2 *vc1 = [[TestVC2 alloc] init];
    vc1.view.backgroundColor = [UIColor brownColor];
    TestVC2 *vc2 = [[TestVC2 alloc] init];
    vc2.view.backgroundColor = [UIColor blueColor];
    TestVC2 *vc3 = [[TestVC2 alloc] init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    TestVC2 *vc4 = [[TestVC2 alloc] init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    TestVC2 *vc5 = [[TestVC2 alloc] init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    [self.segmentBarVC setUpWithItems:@[@"专辑", @"声音", @"下载中",@"shi",@"COO"] childVCs:@[vc1, vc2, vc3,vc4,vc5]];
    
    [self.segmentBarVC.segmentBar updateWithConfig:^(DJSegmentBarConfig *config) {
        
    }];
}

- (DJSegmentBarVC *)segmentBarVC{
    if (!_segmentBarVC) {
        DJSegmentBarVC *segmentBarVC = [[DJSegmentBarVC alloc] init];
        [self addChildViewController:segmentBarVC];
        _segmentBarVC = segmentBarVC;
    }
    return _segmentBarVC;
}


@end
