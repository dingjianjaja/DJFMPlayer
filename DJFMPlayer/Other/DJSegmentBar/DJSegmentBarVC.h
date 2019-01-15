//
//  DJSegmentBarVC.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/15.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSegmentBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJSegmentBarVC : UIViewController

@property (weak, nonatomic)DJSegmentBar *segmentBar;

- (void)setUpWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs;

@end

NS_ASSUME_NONNULL_END
