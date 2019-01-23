//
//  DJMenuView.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJMenuModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DJMenueViewLoadImageBlock)(UIButton *imageBtn, NSURL *url);

@interface DJMenuView : UIScrollView

@property (nonatomic , copy) DJMenueViewLoadImageBlock              loadBlock;
@property (nonatomic, strong) NSArray <id<DJMenuModelProtocol>>*menueModels;

@end

NS_ASSUME_NONNULL_END
