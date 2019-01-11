//
//  DJAudioDownloader.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/9.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DJAudioDownloaderDelegate <NSObject>

- (void)downloading;

@end

@interface DJAudioDownloader : NSObject

@property (weak, nonatomic)id<DJAudioDownloaderDelegate> delegate;

@property (nonatomic, assign) long long totalSize;
@property (nonatomic, assign) long long loadedSize;
@property (nonatomic, assign) long long offset;
@property (nonatomic, strong) NSString *mimeType;


- (void)downLoadWithURL:(NSURL *)url offset:(long long)offset;

@end

NS_ASSUME_NONNULL_END
