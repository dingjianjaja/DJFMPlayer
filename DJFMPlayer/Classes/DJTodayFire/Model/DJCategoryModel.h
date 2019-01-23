//
//  DJCategoryModel.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJSegmentModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DJCategoryModel : NSObject<DJSegmentModelProtocol>
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;

/** 选项卡的ID, 如果不设置, 默认是索引值(从0开始) */
@property (nonatomic, assign, readonly) NSInteger segID;

/** 选项卡内容 */
@property (nonatomic, copy, readonly) NSString *segContent;
@end

NS_ASSUME_NONNULL_END
