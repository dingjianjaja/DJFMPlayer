//
//  DJTabBarController.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/2.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "DJTabBarController.h"
#import "DJTabBar.h"
#import "DJNavigationController.h"
#import "UIImage+DJImage.h"
#import "DJMiddleView.h"


@implementation DJTabBarController

+ (instancetype)shareInstance{
    static DJTabBarController *tabbarC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarC = [[DJTabBarController alloc] init];
    });
    return tabbarC;
}

+ (instancetype)tabBarControllerWithAddChildVCsBlock:(void (^)(DJTabBarController * _Nonnull))addVCBlock{
    DJTabBarController *tabbarVC = [DJTabBarController new];
    if (addVCBlock) {
        addVCBlock(tabbarVC);
    }
    return tabbarVC;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupTabbar];
    
}

- (void)setupTabbar{
    [self setValue:[DJTabBar new] forKey:@"tabBar"];
}

/** 根据参数，x创建并添加对应的子控制器 */
- (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired{
    if (isRequired) {
        DJNavigationController *nav = [[DJNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
        [self addChildViewController:nav];
    }else{
        [self addChildViewController:vc];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    
    UIViewController *vc = self.childViewControllers[selectedIndex];
    if (vc.view.tag == 666) {
        vc.view.tag = 888;
        
        DJMiddleView *middleView = [DJMiddleView middleView];
        middleView.middleClickBlock = [DJMiddleView shareInstance].middleClickBlock;
        middleView.isPlaying = [DJMiddleView shareInstance].isPlaying;
        middleView.middleImg = [DJMiddleView shareInstance].middleImg;
        CGRect frame = middleView.frame;
        frame.size.width = 65;
        frame.size.height = 65;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - 65) * 0.5;
        frame.origin.y = (screenSize.height - 65);
        middleView.frame = frame;
        [vc.view addSubview:middleView];
    }
}

@end
