//
//  CALayer+DJPauseAimate.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/2.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (DJPauseAimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;

@end

NS_ASSUME_NONNULL_END
