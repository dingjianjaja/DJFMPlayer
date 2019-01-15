//
//  TestViewController.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/2.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "TestViewController.h"
#import "TestVC2.h"
#import "DJDownloader.h"
#import "DJDownloaderManager.h"

#import "SegmentMainVC.h"
@interface TestViewController ()

@property (retain, nonatomic)DJDownloader *downLoader;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.tag = 666;
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始下载" style:UIBarButtonItemStyleDone target:self action:@selector(pauseAction:)];
    self.navigationItem.rightBarButtonItem.tag = 111;
}

- (void)pauseAction:(UIBarButtonItem *)sender{
    NSURL *url = [NSURL URLWithString:@"http://macdown.xpgod.com:801/postermac.dmg"];
    if (sender.tag == 111) {
        [[DJDownloaderManager shareInstance] download:url dowloadInfo:^(long long totalSize) {
            NSLog(@"总大小%lld",totalSize);
        } progress:^(float progress) {
            sender.title = [NSString stringWithFormat:@"%.2f",progress];
            NSLog(@"%f",progress);
        } success:^(NSString *filePath) {
            sender.title = @"下载完成";
            NSLog(@"下载完成");
        } failed:^{
            
        }];
        sender.tag = 999;
    }else{
        [[DJDownloaderManager shareInstance] pauseWithURL:url];
        sender.tag = 111;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//    NSLog(@"摸到我了");
//    static BOOL isPlay = NO;
//    isPlay = !isPlay;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"playState" object:@(isPlay)];
//    UIImage *image = [UIImage imageNamed:@"zxy_icon"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"playImage" object:image];
//    //
    [self.navigationController pushViewController:[SegmentMainVC new] animated:YES];
    
    NSURL *url = [NSURL URLWithString:@"http://macdown.xpgod.com:801/postermac.dmg"];
//    [self.downLoader downLoader:url];
    
//    [[DJDownloaderManager shareInstance] download:url dowloadInfo:^(long long totalSize) {
//        NSLog(@"总大小%lld",totalSize);
//    } progress:^(float progress) {
//        NSLog(@"%f",progress);
//    } success:^(NSString *filePath) {
//        NSLog(@"下载完成");
//    } failed:^{
//
//    }];
    
}



@end
