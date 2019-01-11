//
//  DJNavBar.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/2.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "DJNavBar.h"

@implementation DJNavBar

+ (void)setGlobalBackGroundImage:(UIImage *)globalImg{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[NSClassFromString(@"DJNavigationController")]];
    [navBar setBackgroundImage:globalImg forBarMetrics:UIBarMetricsDefault];
}

+ (void)setGlobalTextColor:(UIColor *)globalTextColor andFontSize:(CGFloat)fontSize{
    if (globalTextColor == nil) {
        return;
    }
    if (fontSize < 6 || fontSize > 40) {
        fontSize = 16;
    }
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[NSClassFromString(@"DJNavigationController")]];
    NSDictionary *titleDic = @{NSForegroundColorAttributeName:globalTextColor,
                               NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
                               };
    [navBar setTitleTextAttributes:titleDic];
}

@end
