//
//  DJSegmentBarConfig.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/15.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJSegmentBarConfig : NSObject

/**
 *  控制是否显示更多
 */
@property (nonatomic, assign) BOOL isShowMore;

/** 指示器颜色, 默认红色 */
@property (nonatomic, strong) UIColor *indicatorColor;

/** 指示器高度 */
@property (nonatomic, assign) CGFloat indicatorHeight;

/** 指示器的额外宽度(在跟随字体宽度之外的额外宽度) */
@property (nonatomic, assign) CGFloat indicatorExtraWidth;


/** 选项颜色(普通) */
@property (nonatomic, strong) UIColor *segNormalColor;

/** 选项颜色(选中) */
@property (nonatomic, strong) UIColor *segSelectedColor;

/** 选项字体(普通) */
@property (nonatomic, strong) UIFont *segNormalFont;

/** 选项字体(选中) */
@property (nonatomic, strong) UIFont *segSelectedFont;

/** 选项卡之间的最小间距 */
@property (nonatomic, assign) CGFloat limitMargin;

+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
