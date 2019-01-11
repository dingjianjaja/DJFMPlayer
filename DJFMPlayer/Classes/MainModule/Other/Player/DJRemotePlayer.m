//
//  DJRemotePlayer.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/8.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "DJRemotePlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "NSURL+DJStream.h"
#import "DJRemotePlayerResourceLoaderDelegate.h"

@interface DJRemotePlayer ()<NSCopying,NSMutableCopying>

{
    BOOL _isUserPause;//是否手动暂停
}
@property (retain, nonatomic)AVPlayer *player;

/** 资源加载代理 */
@property (retain, nonatomic)DJRemotePlayerResourceLoaderDelegate *resourceLoaderDelegate;

@end

@implementation DJRemotePlayer

#pragma mark - 单例方法
static DJRemotePlayer *_shareInstance;
+ (instancetype)shareInstance {
    if (!_shareInstance) {
        _shareInstance = [[DJRemotePlayer alloc] init];
    }
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!_shareInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _shareInstance = [super allocWithZone:zone];
        });
    }
    return _shareInstance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _shareInstance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return _shareInstance;
}

#pragma mark - 接口
- (void)playWithURL:(NSURL *)url isCache:(BOOL)isCache{
    NSURL *currentURL = [(AVURLAsset *)self.player.currentItem.asset URL];
    if ([url isEqual:currentURL]) {
        NSLog(@"当前播放任务已经存在");
        [self resume];
        return;
    }
    if (self.player.currentItem) {
        [self removeObserver];
    }
    _url = url;
    if (isCache) {
        url = [url streamingURL];
    }
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    
    /** 拦截加载请求 */
    self.resourceLoaderDelegate = [DJRemotePlayerResourceLoaderDelegate new];
    [asset.resourceLoader setDelegate:self.resourceLoaderDelegate queue:dispatch_get_main_queue()];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"playbackLicklyTokeepUp" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playInterupt) name:AVPlayerItemPlaybackStalledNotification object:nil];
    
    self.player = [AVPlayer playerWithPlayerItem:item];
}

- (void)pause{
    [self.player pause];
    _isUserPause = YES;
    if (self.player) {
        self.state = DJRemotePlayerStatePause;
    }
}

- (void)resume{
    [self.player play];
    _isUserPause = NO;
    if (self.player && self.player.currentItem.playbackLikelyToKeepUp) {
        self.state = DJRemotePlayerStatePlaying;
    }
}

- (void)stop{
    [self.player pause];
    self.player = nil;
    if (self.player) {
        self.state = DJRemotePlayerStateStopped;
    }
}

- (void)seekWithProgress:(float)progress{
    if (progress < 0 || progress > 1) {
        return;
    }
    CMTime totalTime = self.player.currentItem.duration;
    NSTimeInterval totalSec = CMTimeGetSeconds(totalTime);
    NSTimeInterval playTimeSec = totalSec * progress;
    CMTime currentTime = CMTimeMake(playTimeSec, 1);
    
    [self.player seekToTime:currentTime completionHandler:^(BOOL finished) {
        if (finished) {
            NSLog(@"确定加载这个时间点的资源");
        }else{
            NSLog(@"取消加载这个时间点的资源");
        }
    }];
}

- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer{
    NSTimeInterval totalTimeSec = [self totalTime];
    NSTimeInterval playTimeSec = [self currentTime];
    playTimeSec += timeDiffer;
    [self seekWithProgress:playTimeSec / totalTimeSec];
    
}



/**
 播放速率
 
 @param rate 速率, 0.5 -- 2.0
 */
- (void)setRate:(float)rate {
    [self.player setRate:rate];
}

/**
 获取速率
 
 @return 速率
 */
- (float)rate {
    return self.player.rate;
}

/**
 设置静音
 
 @param muted 静音
 */
- (void)setMuted:(BOOL)muted {
    self.player.muted = muted;
}

/**
 是否静音
 
 @return 是否静音
 */
- (BOOL)muted {
    return self.player.muted;
}

/**
 声音大小
 
 @param volume 音量
 */
- (void)setVolume:(float)volume {
    
    if (volume < 0 || volume > 1) {
        return;
    }
    if (volume > 0) {
        [self setMuted:NO];
    }
    
    self.player.volume = volume;
}

/**
 声音大小
 
 @return 音量
 */
- (float)volume {
    return self.player.volume;
    
}



#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerItemStatusFailed:{
                NSLog(@"失败");
            }
                break;
            case AVPlayerItemStatusUnknown:{
                NSLog(@"状态未知");
            }
                break;
            case AVPlayerItemStatusReadyToPlay:{
                NSLog(@"准备好，可以播放");
                [self resume];
            }
                break;
            default:
                break;
        }
    }else if([keyPath isEqualToString:@""]){
        BOOL ptk = [change[NSKeyValueChangeNewKey] boolValue];
        if (ptk) {
            NSLog(@"当前的资源，准备的已经足够播放了");
            /** 用户手动暂停优先级最高 */
            if (!_isUserPause) {
                [self resume];
            }else{
                
            }
        }else{
            NSLog(@"资源还不够，正在加载");
            self.state = DJRemotePlayerStateLoading;
        }
    }
}


- (void)removeObserver{
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"playbackLicklyTokeepUp"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - setter
- (void)setState:(DJRemotePlayerState)state{
    _state = state;
}


#pragma mark -
/**
 播放完成
 */
- (void)playEnd {
    NSLog(@"播放完成");
    self.state = DJRemotePlayerStateStopped;
}

/**
 被打断
 */
- (void)playInterupt {
    // 来电话, 资源加载跟不上
    NSLog(@"播放被打断");
    self.state = DJRemotePlayerStatePause;
}

/**
 当前音频资源总时长
 
 @return 总时长
 */
-(NSTimeInterval)totalTime {
    CMTime totalTime = self.player.currentItem.duration;
    NSTimeInterval totalTimeSec = CMTimeGetSeconds(totalTime);
    if (isnan(totalTimeSec)) {
        return 0;
    }
    return totalTimeSec;
}
/**
 当前音频资源总时长(格式化后)
 
 @return 总时长 01:02
 */
- (NSString *)totalTimeFormat {
    return [NSString stringWithFormat:@"%02d:%02d", (int)self.totalTime / 60, (int)self.totalTime % 60];
}

/**
 当前音频资源播放时长
 
 @return 播放时长
 */
- (NSTimeInterval)currentTime {
    CMTime playTime = self.player.currentItem.currentTime;
    NSTimeInterval playTimeSec = CMTimeGetSeconds(playTime);
    if (isnan(playTimeSec)) {
        return 0;
    }
    return playTimeSec;
}
/**
 当前音频资源播放时长(格式化后)
 
 @return 播放时长
 */
- (NSString *)currentTimeFormat {
    return [NSString stringWithFormat:@"%02d:%02d", (int)self.currentTime / 60, (int)self.currentTime % 60];
}

/**
 当前播放进度
 
 @return 播放进度
 */
- (float)progress {
    if (self.totalTime == 0) {
        return 0;
    }
    return self.currentTime / self.totalTime;
}

/**
 资源加载进度
 
 @return 加载进度
 */
- (float)loadDataProgress {
    
    if (self.totalTime == 0) {
        return 0;
    }
    
    CMTimeRange timeRange = [[self.player.currentItem loadedTimeRanges].lastObject CMTimeRangeValue];
    
    CMTime loadTime = CMTimeAdd(timeRange.start, timeRange.duration);
    NSTimeInterval loadTimeSec = CMTimeGetSeconds(loadTime);
    
    return loadTimeSec / self.totalTime;
    
}


@end
