//
//  DJDownloaderManager.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/3.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "DJDownloaderManager.h"
#import "NSString+md5.h"

@interface DJDownloaderManager ()<NSCopying,NSMutableCopying>
@property (nonatomic, strong) NSMutableDictionary *downLoadInfo;
@end

@implementation DJDownloaderManager

static DJDownloaderManager *_shareInstance;

+ (instancetype)shareInstance{
    if (_shareInstance == nil) {
        _shareInstance = [[self alloc] init];
    }
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!_shareInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _shareInstance = [super allocWithZone:zone];
        });
    }
    return _shareInstance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _shareInstance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _shareInstance;
}

- (void)download:(NSURL *)url dowloadInfo:(DownloadInfoType)downloadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    NSString *urlMD5 = [url.absoluteString md5];
    
    DJDownloader *downloader = self.downLoadInfo[urlMD5];
    if (downloader == nil) {
        downloader = [[DJDownloader alloc] init];
        self.downLoadInfo[urlMD5] = downloader;
    }
    __weak typeof(self) weakSelf = self;
    [downloader downloader:url downloadInfo:downloadInfo progress:progressBlock success:^(NSString *filePath) {
        /** 拦截成功的block */
        [weakSelf.downLoadInfo removeObjectForKey:urlMD5];
        successBlock(filePath);
    } faild:failedBlock];
}

- (void)pauseWithURL:(NSURL *)url{
    NSString *urlMD5 = [url.absoluteString md5];
    DJDownloader *downloader = self.downLoadInfo[urlMD5];
    [downloader pauseCurrentTask];
}

- (void)resumeWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    DJDownloader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader resumeCurrentTask];
}
- (void)cancelWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    DJDownloader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader cacelCurrentTask];
    
}


- (void)pauseAll {
    
    [self.downLoadInfo.allValues performSelector:@selector(pauseCurrentTask) withObject:nil];
    
}
- (void)resumeAll {
    [self.downLoadInfo.allValues performSelector:@selector(resumeCurrentTask) withObject:nil];
}

#pragma mark -lazyloading
- (NSMutableDictionary *)downLoadInfo{
    if (!_downLoadInfo) {
        _downLoadInfo = [NSMutableDictionary dictionary];
    }
    return _downLoadInfo;
}

@end
