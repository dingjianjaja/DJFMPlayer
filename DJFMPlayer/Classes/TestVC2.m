//
//  TestVC2.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/2.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "TestVC2.h"
#import "DJRemotePlayer.h"

@interface TestVC2 ()
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *loadPV;

@property (nonatomic, weak) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UISlider *playSlider;

@property (weak, nonatomic) IBOutlet UIButton *mutedBtn;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.tag = 666;
    self.view.backgroundColor = [UIColor brownColor];
    [self timer];
}

- (NSTimer *)timer{
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}
- (IBAction)play:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/10736445.mp3"];
    [[DJRemotePlayer shareInstance] playWithURL:url isCache:YES];
}

- (void)update{
    self.playTimeLabel.text =  [DJRemotePlayer shareInstance].currentTimeFormat;
    self.totalTimeLabel.text = [DJRemotePlayer shareInstance].totalTimeFormat;
    
    self.playSlider.value = [DJRemotePlayer shareInstance].progress;
    
    self.volumeSlider.value = [DJRemotePlayer shareInstance].volume;
    
    self.loadPV.progress = [DJRemotePlayer shareInstance].loadDataProgress;
    
    self.mutedBtn.selected = [DJRemotePlayer shareInstance].muted;
}



- (IBAction)pause:(id)sender {
    [[DJRemotePlayer shareInstance] pause];
}

- (IBAction)resume:(id)sender {
    [[DJRemotePlayer shareInstance] resume];
}
- (IBAction)kuaijin:(id)sender {
    [[DJRemotePlayer shareInstance] seekWithTimeDiffer:15];
}
- (IBAction)progress:(UISlider *)sender {
    [[DJRemotePlayer shareInstance] seekWithProgress:sender.value];
}
- (IBAction)rate:(id)sender {
    [[DJRemotePlayer shareInstance] setRate:2];
}
- (IBAction)muted:(UIButton *)sender {
    sender.selected = !sender.selected;
    [[DJRemotePlayer shareInstance] setMuted:sender.selected];
}
- (IBAction)volume:(UISlider *)sender {
    [[DJRemotePlayer shareInstance] setVolume:sender.value];
}

@end
