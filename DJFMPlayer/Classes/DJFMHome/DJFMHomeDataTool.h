//
//  DJFMHomeDataTool.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/18.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJHomeTabModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJFMHomeDataTool : NSObject

+ (instancetype)shareInstance;

- (void)getHomeTabs: (void(^)(NSArray<DJHomeTabModel *> *tabMs))resultBlock;

@end

NS_ASSUME_NONNULL_END
