//
//  DJRemotePlayerResourceLoaderDelegate.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/9.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "DJRemotePlayerResourceLoaderDelegate.h"
#import "DJRemoteAudioFile.h"
#import "DJAudioDownloader.h"
#import "NSURL+DJStream.h"

@interface DJRemotePlayerResourceLoaderDelegate ()<DJAudioDownloaderDelegate>

@property (retain, nonatomic)DJAudioDownloader *downloader;

@property (nonatomic, strong) NSMutableArray *loadingRequests;

@end

@implementation DJRemotePlayerResourceLoaderDelegate

/** 当需要播放一段音频资源时，会跑一个请求，给这个对象 */
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    NSLog(@"%@",loadingRequest);
    
    NSURL *url = [loadingRequest.request.URL httpURL];
    long long requestOffset = loadingRequest.dataRequest.requestedOffset;
    long long currentOffset = loadingRequest.dataRequest.currentOffset;
    if (requestOffset != currentOffset) {
        requestOffset = currentOffset;
    }
    if ([DJRemoteAudioFile cacheFileExists:url]) {
        [self handleLoadingRequest:loadingRequest];
        return YES;
    }
    
    [self.loadingRequests addObject:loadingRequest];
    
    if (self.downloader.loadedSize == 0) {
        [self.downloader downLoadWithURL:url offset:requestOffset];
        return YES;
    }
    if (requestOffset < self.downloader.offset || requestOffset > (self.downloader.offset + self.downloader.loadedSize + 666)) {
        [self.downloader downLoadWithURL:url offset:requestOffset];
        return YES;
    }
    
    [self handleAllLoadingRequest];
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    NSLog(@"取消请求");
    [self.loadingRequests removeObject:loadingRequest];
    
}

- (void)downloading{
    [self handleAllLoadingRequest];
}




#pragma mark - 私有方法
/** 处理本地已经下载的资源文件 */
- (void)handleLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    NSURL *url = loadingRequest.request.URL;
    long long totalSize = [DJRemoteAudioFile cacheFileSize:url];
    loadingRequest.contentInformationRequest.contentLength = totalSize;
    NSString *contentType = [DJRemoteAudioFile contentType:url];
    loadingRequest.contentInformationRequest.contentType = contentType;
    loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
    NSData *data = [NSData dataWithContentsOfFile:[DJRemoteAudioFile cacheFilePath:url] options:NSDataReadingMappedIfSafe error:nil];
    long long requestOffset = loadingRequest.dataRequest.requestedOffset;
    long long requestLength = loadingRequest.dataRequest.requestedLength;
    NSData *subData = [data subdataWithRange:NSMakeRange(requestOffset, requestLength)];
    [loadingRequest.dataRequest respondWithData:subData];
    [loadingRequest finishLoading];
}

- (void)handleAllLoadingRequest{
    NSLog(@"%@",self.loadingRequests);
    NSMutableArray *deleteRequest = [NSMutableArray array];
    for (AVAssetResourceLoadingRequest *loadingRequest in self.loadingRequests) {
        NSURL *url = loadingRequest.request.URL;
        long long totalSize = self.downloader.totalSize;
        loadingRequest.contentInformationRequest.contentLength = totalSize;
        NSString *contentType = self.downloader.mimeType;
        loadingRequest.contentInformationRequest.contentType = contentType;
        loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
        
        // 2. 填充数据
        NSData *data = [NSData dataWithContentsOfFile:[DJRemoteAudioFile tmpFilePath:url] options:NSDataReadingMappedIfSafe error:nil];
        if (data == nil) {
            data = [NSData dataWithContentsOfFile:[DJRemoteAudioFile cacheFilePath:url] options:NSDataReadingMappedIfSafe error:nil];
        }
        
        long long requestOffset = loadingRequest.dataRequest.requestedOffset;
        long long currentOffset = loadingRequest.dataRequest.currentOffset;
        if (requestOffset != currentOffset) {
            requestOffset = currentOffset;
        }
        NSInteger requestLength = loadingRequest.dataRequest.requestedLength;
        
        
        long long responseOffset = requestOffset - self.downloader.offset;
        long long responseLength = MIN(self.downloader.offset + self.downloader.loadedSize - requestOffset, requestLength) ;
        
        NSData *subData = [data subdataWithRange:NSMakeRange(responseOffset, responseLength)];
        
        [loadingRequest.dataRequest respondWithData:subData];
        
        
        
        // 3. 完成请求(必须把所有的关于这个请求的区间数据, 都返回完之后, 才能完成这个请求)
        if (requestLength == responseLength) {
            [loadingRequest finishLoading];
            [deleteRequest addObject:loadingRequest];
        }
    }
    [self.loadingRequests removeObjectsInArray:deleteRequest];
}



#pragma mark - lazyloading
- (DJAudioDownloader *)downloader{
    if (!_downloader) {
        _downloader = [[DJAudioDownloader alloc] init];
        _downloader.delegate = self;
    }
    return _downloader;
}

- (NSMutableArray *)loadingRequests{
    if (!_loadingRequests) {
        _loadingRequests = [NSMutableArray array];
    }
    return _loadingRequests;
}

@end
