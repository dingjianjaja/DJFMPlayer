//
//  DJSegmentBar.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/15.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSegmentBarConfig.h"
#import "DJSegmentModelProtocol.h"
#import "NSString+SegmentModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DJSegmentModelProtocol;
@class DJSegmentBar;
@protocol DJSegmentBarDelegate <NSObject>

- (void)segmentBar:(DJSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

@interface DJSegmentBar : UIView

@property (nonatomic, strong) NSArray <NSString *>*items;
/** 当前选中的索引, 双向设置 */
@property (nonatomic, assign) NSInteger selectIndex;
/** 选项卡模型数组, 此处传递字符串数组也可以, 只不过索引变成了对应的数组下标 */
@property (nonatomic, strong) NSArray <id<DJSegmentModelProtocol>>*segmentMs;

@property (nonatomic, weak) id<DJSegmentBarDelegate> delegate;

+ (instancetype)segmentBarWithFrame:(CGRect)frame;

+ (instancetype)segmentBarWithConfig: (DJSegmentBarConfig *)config;

- (void)updateWithConfig: (void(^)(DJSegmentBarConfig *config))configBlock;
@end

NS_ASSUME_NONNULL_END
