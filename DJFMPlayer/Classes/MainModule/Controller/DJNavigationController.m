//
//  DJViewController.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/2.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "DJNavigationController.h"
#import "DJNavBar.h"
#import "DJMiddleView.h"

@interface DJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation DJNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setValue:[DJNavBar new] forKey:@"navigationBar"];
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 设置手势代理 */
    UIGestureRecognizer *gester = self.interactivePopGestureRecognizer;
    UIPanGestureRecognizer *panGester = [[UIPanGestureRecognizer alloc] initWithTarget:gester.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    [gester.view addGestureRecognizer:panGester];
    gester.delaysTouchesBegan = YES;
    panGester.delegate = self;
}


- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 拦截每一个push的控制器, 进行统一设置
    // 过滤第一个根控制器
    if (self.childViewControllers.count > 0) {
        //        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem customBackItemWithTarget:self action:@selector(back)];
        
        //统一设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_n"] style:0 target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
    if (viewController.view.tag == 666) {
        viewController.view.tag = 888;
        DJMiddleView *middleView = [DJMiddleView middleView];
        middleView.middleClickBlock = [DJMiddleView shareInstance].middleClickBlock;
        middleView.isPlaying = [DJMiddleView shareInstance].isPlaying;
        middleView.middleImg = [DJMiddleView shareInstance].middleImg;
        CGRect frame = middleView.frame;
        frame.size.width = 65;
        frame.size.height = 65;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - 65) * 0.5;
        frame.origin.y = screenSize.height - 65;
        middleView.frame = frame;
        [viewController.view addSubview:middleView];
    }
    
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果根控制器也要返回手势有效, 就会造成假死状态
    // 所以, 需要过滤根控制器
    if(self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

@end
