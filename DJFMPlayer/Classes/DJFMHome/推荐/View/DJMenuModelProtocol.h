//
//  DJMenuModelProtocol.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DJMenuModelProtocol <NSObject>
@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) void(^clickBlock)();
@end

NS_ASSUME_NONNULL_END
