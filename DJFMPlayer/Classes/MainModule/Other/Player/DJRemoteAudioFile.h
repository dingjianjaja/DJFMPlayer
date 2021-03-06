//
//  DJRemoteAudioFile.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/9.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJRemoteAudioFile : NSObject

/**
 根据url, 获取相应的本地, 缓存路径, 下载完成的路径
 */
+ (NSString *)cacheFilePath:(NSURL *)url;
+ (long long)cacheFileSize:(NSURL *)url;
+ (BOOL)cacheFileExists:(NSURL *)url;

+ (NSString *)tmpFilePath:(NSURL *)url;
+ (long long)tmpFileSize:(NSURL *)url;
+ (BOOL)tmpFileExists:(NSURL *)url;
+ (void)clearTmpFile:(NSURL *)url;

+ (NSString *)contentType:(NSURL *)url;
+ (void)moveTmpPathToCachePath:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
