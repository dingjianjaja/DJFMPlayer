//
//  DJLiveModel.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJLiveModel : NSObject

@property (nonatomic, copy)  NSString *chatId;
@property (nonatomic, copy, getter=adImgURL)  NSString *coverPath;
@property (nonatomic, copy)  NSString *endTs;
@property (nonatomic, copy)  NSString *id;
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, copy)  NSString *onlineCount;
@property (nonatomic, copy)  NSString *playCount;
@property (nonatomic, copy)  NSString *scheduleId;
@property (nonatomic, copy)  NSString *shortDescription;
@property (nonatomic, copy)  NSString *startTs;
@property (nonatomic, copy)  NSString *status;

@property (nonatomic, copy) void(^clickBlock)();

@end

NS_ASSUME_NONNULL_END
