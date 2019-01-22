//
//  DJHomeTabModel.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/18.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJSegmentModelProtocol.h"

@protocol DJSegmentModelProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface DJHomeTabModel : NSObject<DJSegmentModelProtocol>

/** 选项卡的ID, 如果不设置, 默认是索引值(从0开始) */
@property (nonatomic, assign) NSInteger segID;
/**
 内容类型
 */
@property (nonatomic, copy) NSString *contentType;
/**
 标题
 */
@property (nonatomic, copy, getter=segContent) NSString *title;

@end

NS_ASSUME_NONNULL_END
