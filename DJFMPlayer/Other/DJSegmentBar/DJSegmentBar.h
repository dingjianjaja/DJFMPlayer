//
//  DJSegmentBar.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/15.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSegmentBarConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class DJSegmentBar;
@protocol DJSegmentBarDelegate <NSObject>

- (void)segmentBar:(DJSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

@interface DJSegmentBar : UIView

@property (nonatomic, strong) NSArray <NSString *>*items;
/** 当前选中的索引, 双向设置 */
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, weak) id<DJSegmentBarDelegate> delegate;

+ (instancetype)segmentBarWithFrame:(CGRect)frame;

- (void)updateWithConfig: (void(^)(DJSegmentBarConfig *config))configBlock;
@end

NS_ASSUME_NONNULL_END
