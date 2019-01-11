//
//  DJDownloader.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/2.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "DJDownloader.h"
#import "DJFileTool.h"

#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kTmpPath NSTemporaryDirectory()

@interface DJDownloader ()<NSURLSessionDataDelegate>
{
    // 记录文件临时下载大小
    long long _tmpSize;
    // 记录文件总大小
    long long _totalSize;
}
/** 下载会话 */
@property (nonatomic, strong) NSURLSession *session;
/** 下载完成路径 */
@property (nonatomic, copy) NSString *downLoadedPath;
/** 下载临时路径 */
@property (nonatomic, copy) NSString *downLoadingPath;
/** 文件输出流 */
@property (nonatomic, strong) NSOutputStream *outputStream;
/** 当前下载任务 */
@property (nonatomic, weak) NSURLSessionDataTask *dataTask;

@end

@implementation DJDownloader


- (void)downloader:(NSURL *)url downloadInfo:(DownloadInfoType)downloadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock faild:(FailedBlockType)failedBock{
    self.downloadInfo = downloadInfo;
    self.progressChange = progressBlock;
    self.successBlock = successBlock;
    self.faildBlcok =  failedBock;
    
    [self downLoader:url];
}

- (void)downLoader:(NSURL *)url{
    NSLog(@"kTmpPath：%@\n",kTmpPath);
    NSLog(@"kCachePath：%@",kCachePath);
    
    if ([url isEqual:self.dataTask.originalRequest.URL]) {
        // 判断当前的状态, 如果是暂停状态
        if (self.state == DJDownloadStatePause) {
            // 继续
            [self resumeCurrentTask];
            return;
        }
    }
    [self cacelCurrentTask];
    NSString *fileName = url.lastPathComponent;
    self.downLoadedPath = [kCachePath stringByAppendingPathComponent:fileName];
    self.downLoadingPath = [kTmpPath stringByAppendingPathComponent:fileName];
    
    if ([DJFileTool fileExists:self.downLoadedPath]) {
        NSLog(@"已经下载完成");
        return;
    }
    
    if (![DJFileTool fileExists:self.downLoadingPath]) {
        [self downLoadWithURL:url offset:0];
        return;
    }
    
    _tmpSize = [DJFileTool fileSize:self.downLoadingPath];
    [self downLoadWithURL:url offset:_tmpSize];
}

/**
 暂停任务
 注意:
 - 如果调用了几次继续
 - 调用几次暂停, 才可以暂停
 - 解决方案: 引入状态
 */
- (void)pauseCurrentTask {
    if (self.state == DJDownloadStateDownloading) {
        self.state = DJDownloadStatePause;
        [self.dataTask suspend];
    }
}

/**
 取消当前任务
 */
- (void)cacelCurrentTask {
    self.state = DJDownloadStatePause;
    [self.session invalidateAndCancel];
    self.session = nil;
}

/**
 取消任务, 并清理资源
 */
- (void)cacelAndClean {
    [self cacelCurrentTask];
    [DJFileTool removeFile:self.downLoadingPath];
    // 下载完成的文件 -> 手动删除某个声音 -> 统一清理缓存
}

/**
 继续任务
 - 如果调用了几次暂停, 就要调用几次继续, 才可以继续
 - 解决方案: 引入状态
 */
- (void)resumeCurrentTask {
    if (self.dataTask && self.state == DJDownloadStatePause) {
        self.state = DJDownloadStateDownloading;
        [self.dataTask resume];
    }
}


#pragma mark -NSURLSessionDataDelegate
/**
 第一次接受到相应的时候调用(响应头, 并没有具体的资源内容)
 通过这个方法, 里面, 系统提供的回调代码块, 可以控制, 是继续请求, 还是取消本次请求
 
 @param session 会话
 @param dataTask 任务
 @param response 响应头信息
 @param completionHandler 系统回调代码块, 通过它可以控制是否继续接收数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    _totalSize = [response.allHeaderFields[@"Content-Length"] longLongValue];
    NSString *contentRangeStr = response.allHeaderFields[@"Content-Range"];
    if (contentRangeStr.length != 0) {
        _totalSize = [[contentRangeStr componentsSeparatedByString:@"/"].lastObject longLongValue];
    }
    
    if (self.downloadInfo != nil) {
        self.downloadInfo(_totalSize);
    }
    
    if (_tmpSize == _totalSize) {
        NSLog(@"下载完成");
        [DJFileTool moveFile:self.downLoadingPath toPath:self.downLoadedPath];
        completionHandler(NSURLSessionResponseCancel);
        self.state = DJDownloadStatePauseSuccess;
        return;
    }
    
    if (_tmpSize > _totalSize) {
        NSLog(@"删除缓存");
        [DJFileTool removeFile:self.downLoadingPath];
        completionHandler(NSURLSessionResponseCancel);
        NSLog(@"重新开始下载");
        [self downLoader:response.URL];
        return;
    }
    self.state = DJDownloadStateDownloading;
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.downLoadingPath append:YES];
    [self.outputStream open];
    completionHandler(NSURLSessionResponseAllow);
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    _tmpSize += data.length;
    self.progress = 1.0 * _tmpSize / _totalSize;
    
    
    [self.outputStream write:data.bytes maxLength:data.length];
    NSLog(@"在接收后续数据");
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"请求完成");
    if (error == nil) {
        [DJFileTool moveFile:self.downLoadingPath toPath:self.downLoadedPath];
        self.state = DJDownloadStatePauseSuccess;
    }else{
        NSLog(@"有问题");
        if (-999 == error.code) {
            self.state = DJDownloadStatePause;
        }else{
            self.state = DJDownloadStatePauseFaild;
        }
    }
    [self.outputStream close];
}

#pragma mark -setter
- (void)setState:(DJDownloadState)state{
    if (_state == state) {
        return;
    }
    _state = state;
    if (self.stateChange) {
        self.stateChange(_state);
    }
    if (_state == DJDownloadStatePauseSuccess && self.successBlock) {
        self.successBlock(self.downLoadedPath);
    }
    if (_state == DJDownloadStatePauseFaild && self.faildBlcok) {
        self.faildBlcok();
    }
}

- (void)setProgress:(float)progress{
    _progress = progress;
    if (self.progressChange) {
        self.progressChange(_progress);
    }
}

#pragma mark - 私有方法
/**
 根据开始字节, 请求资源
 
 @param url url
 @param offset 开始字节
 */
- (void)downLoadWithURL:(NSURL *)url offset:(long long)offset {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
    // 通过控制range, 控制请求资源字节区间
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-", offset] forHTTPHeaderField:@"Range"];
    // session 分配的task, 默认情况, 挂起状态
    self.dataTask = [self.session dataTaskWithRequest:request];
    [self.dataTask resume];
    
}


#pragma mark - 懒加载
/**
 懒加载会话
 @return 会话
 */
- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

@end
