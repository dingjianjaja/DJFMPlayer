//
//  SegmentMainVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/15.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "SegmentMainVC.h"
#import "TestVC2.h"

@interface SegmentMainVC ()
@end

@implementation SegmentMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    
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

}



@end
