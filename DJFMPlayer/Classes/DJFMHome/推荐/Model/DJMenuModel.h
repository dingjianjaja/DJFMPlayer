//
//  DJMenuModel.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJMenuModel : NSObject
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy, getter=imageURL) NSString *coverPath;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void(^clickBlock)();
@end

NS_ASSUME_NONNULL_END
