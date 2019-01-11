//
//  NSURL+DJStream.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/8.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (DJStream)

/**
 获取streaming协议的url地址
 */
- (NSURL *)streamingURL;


- (NSURL *)httpURL;
@end

NS_ASSUME_NONNULL_END
