//
//  DJSessionManager.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost,
};

@interface DJSessionManager : NSObject

- (void)setValue:(NSString *)value forHttpField:(NSString *)field;

- (void)request:(RequestType)requestType urlStr:(NSString *)urlStr parameter:(NSDictionary *)param resultBlock:(void(^)(id responseObject,NSError *error))resultBlock;

@end

NS_ASSUME_NONNULL_END
