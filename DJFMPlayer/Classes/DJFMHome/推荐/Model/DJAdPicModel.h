//
//  DJAdPicModel.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJFocusImageModel.h"
#import "DJLiveModel.h"
#import "DJTuiguangModel.h"
#import "DJClassItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJAdPicModel : NSObject

@property (retain, nonatomic)DJFocusImageModel *focusImageM;

@property (nonatomic, strong) DJLiveModel *liveM;

@property (nonatomic, strong) DJTuiguangModel *tuiguangM;

@property (nonatomic, strong) DJClassItemModel *classItemM;


/**
 *  广告图片URL
 */
@property (nonatomic, copy) NSURL *adImgURL;

/**
 *  点击广告, 需要跳转的URL
 */
@property (nonatomic, copy) NSURL *adLinkURL;

/**
 *  点击执行的代码块(优先级高于adLinkURL)
 */
@property (nonatomic, copy) void(^clickBlock)();
@end

NS_ASSUME_NONNULL_END
