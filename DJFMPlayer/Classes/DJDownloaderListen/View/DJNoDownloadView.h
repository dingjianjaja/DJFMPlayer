//
//  DJNoDownloadView.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJNoDownloadView : UIView

@property (retain, nonatomic)UIImage *noDataImg;
@property (nonatomic , copy) void(^clickBlock)();

+ (instancetype)noDownloadView;

@end

NS_ASSUME_NONNULL_END
