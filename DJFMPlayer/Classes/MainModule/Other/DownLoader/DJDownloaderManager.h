//
//  DJDownloaderManager.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/3.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJDownloaderManager : NSObject

+ (instancetype)shareInstance;

- (void)download:(NSURL *)url dowloadInfo:(DownloadInfoType)downloadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;

- (void)pauseWithURL:(NSURL *)url;
- (void)resumeWithURL:(NSURL *)url;
- (void)cancelWithURL:(NSURL *)url;

- (void)pauseAll;
- (void)resumeAll;

@end

NS_ASSUME_NONNULL_END
