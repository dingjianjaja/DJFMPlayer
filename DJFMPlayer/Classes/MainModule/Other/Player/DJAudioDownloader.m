//
//  DJAudioDownloader.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/9.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "DJAudioDownloader.h"
#import "DJRemoteAudioFile.h"

@interface DJAudioDownloader ()<NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOutputStream *outputStream;
@property (nonatomic, strong) NSURL *url;

@end

@implementation DJAudioDownloader

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void)downLoadWithURL:(NSURL *)url offset:(long long)offset{
    [self cancelAndClean];
    self.url = url;
    self.offset = offset;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-",offset] forHTTPHeaderField:@"Range"];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    [task resume];
}

- (void)cancelAndClean{
    [self.session invalidateAndCancel];
    self.session = nil;
    [DJRemoteAudioFile clearTmpFile:self.url];
    self.loadedSize = 0;
}

#pragma mark -NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    self.totalSize = [response.allHeaderFields[@"Content-Length"] longLongValue];
    NSString *contentRangeStr = response.allHeaderFields[@"Content-Length"];
    if (contentRangeStr.length != 0) {
        self.totalSize = [[contentRangeStr componentsSeparatedByString:@"/"].lastObject longLongValue];
    }
    self.mimeType = response.MIMEType;
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:[DJRemoteAudioFile tmpFilePath:self.url] append:YES];
    [self.outputStream open];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    self.loadedSize += data.length;
    [self.outputStream write:data.bytes maxLength:data.length];
    if ([self.delegate respondsToSelector:@selector(downloading)]) {
        [self.delegate downloading];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error == nil) {
        NSURL *url = self.url;
        if ([DJRemoteAudioFile tmpFileSize:url] == self.totalSize) {
            [DJRemoteAudioFile moveTmpPathToCachePath:url];
        }
    }else{
        NSLog(@"有错误");
    }
}


@end 
