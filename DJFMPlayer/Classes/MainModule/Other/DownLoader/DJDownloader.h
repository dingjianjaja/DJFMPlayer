//
//  DJDownloader.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/2.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, DJDownloadState) {
    DJDownloadStatePause,
    DJDownloadStateDownloading,
    DJDownloadStatePauseSuccess,
    DJDownloadStatePauseFaild
};

typedef void(^DownloadInfoType)(long long totalSize);
typedef void(^ProgressBlockType)(float progress);
typedef void(^SuccessBlockType)(NSString *filePath);
typedef void(^FailedBlockType)(void);
typedef void(^StateChangeType)(DJDownloadState state);


NS_ASSUME_NONNULL_BEGIN

@interface DJDownloader : NSObject

@property (nonatomic , copy) DownloadInfoType               downloadInfo;
@property (nonatomic , copy) StateChangeType               stateChange;
@property (nonatomic , copy) ProgressBlockType               progressChange;
@property (nonatomic , copy) SuccessBlockType               successBlock;
@property (nonatomic , copy) FailedBlockType               faildBlcok;

@property (nonatomic, assign, readonly) DJDownloadState state;
@property (nonatomic, assign, readonly) float progress;

- (void)downloader:(NSURL *)url downloadInfo:(DownloadInfoType)downloadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock faild:(FailedBlockType)failedBock;

/**
 根据URL地址下载资源, 如果任务已经存在, 则执行继续动作
 @param url 资源路径
 */
- (void)downLoader:(NSURL *)url;

/**
 暂停任务
 注意:
 - 如果调用了几次继续
 - 调用几次暂停, 才可以暂停
 - 解决方案: 引入状态
 */
- (void)pauseCurrentTask;

/**
 取消任务
 */
- (void)cacelCurrentTask;

/**
 取消任务, 并清理资源
 */
- (void)cacelAndClean;

- (void)resumeCurrentTask;

@end

NS_ASSUME_NONNULL_END
