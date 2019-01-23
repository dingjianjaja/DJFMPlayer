//
//  DJAdPicView.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJAdLoopProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoadImageBlock)(UIImageView *imageView, NSURL *url);

@protocol DJAdLoopViewDelegate <NSObject>

- (void)adLoopViewDidSelectedPicModel:(id<DJAdLoopProtocol>)picM;

@end

@interface DJAdLoopView : UIView

+ (instancetype)picViewWithLoadImageBlock:(LoadImageBlock)loadBlock;
/**
 *  用于加载图片的代码块, 必须赋值
 */
@property (nonatomic, copy) LoadImageBlock loadBlock;

/**
 *  用于告知外界, 当前滚动到的是哪个广告数据模型
 */
@property (nonatomic, strong) id<DJAdLoopViewDelegate> delegate;

/**
 *  用来展示图片的数据源
 */
@property (nonatomic, strong) NSArray <id <DJAdLoopProtocol>>*picModels;


@end

NS_ASSUME_NONNULL_END
