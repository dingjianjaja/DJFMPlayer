//
//  DJRecommendDataTool.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJMenuModel.h"
#import "DJAdPicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJRecommendDataTool : NSObject


+ (instancetype)shareInstance;

/**
 *  获取发现模块的  "广告列表"
 *
 *  @param result 广告列表
 */
- (void)getAdList:(void(^)(NSArray <DJAdPicModel *>*adMs, NSError *error))result;


/**
 *  获取发现模块的 "图文菜单"
 *
 *  @param result 图文菜单列表
 */
- (void)getPicMenueList:(void(^)(NSArray <DJMenuModel *>*menuePicMs, NSError *error))result;

@end

NS_ASSUME_NONNULL_END
