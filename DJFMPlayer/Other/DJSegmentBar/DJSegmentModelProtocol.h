//
//  DJSegmentModelProtocol.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/18.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DJSegmentModelProtocol <NSObject>
/** 选项卡的ID, 如果不设置, 默认是索引值(从0开始) */
@property (nonatomic, assign, readonly) NSInteger segID;

/** 选项卡内容 */
@property (nonatomic, copy, readonly) NSString *segContent;
@end

NS_ASSUME_NONNULL_END
