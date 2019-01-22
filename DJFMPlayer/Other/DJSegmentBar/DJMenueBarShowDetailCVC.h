//
//  DJMenueBarShowDetailCVC.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/22.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+SegmentModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJMenueBarShowDetailCVC : UICollectionViewController

@property (nonatomic, assign) CGFloat expectedHeight;
@property (retain, nonatomic)NSArray <id<DJSegmentModelProtocol>> *items;

@end

NS_ASSUME_NONNULL_END
