//
//  DJSessionManager.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJSessionManager.h"
#import "AFNetworking.h"

@interface DJSessionManager ()

@property (retain, nonatomic)AFHTTPSessionManager *sessionManager;

@end

@implementation DJSessionManager

- (void)setValue:(NSString *)value forHttpField:(NSString *)field{
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] init];
        NSMutableSet *setM = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [setM addObject:@"text/plain"];
        [setM addObject:@"text/html"];
        _sessionManager.responseSerializer.acceptableContentTypes = [setM copy];
    }
    return _sessionManager;
}

- (void)request:(RequestType)requestType urlStr:(NSString *)urlStr parameter:(NSDictionary *)param resultBlock:(void (^)(id _Nonnull, NSError * _Nonnull))resultBlock{
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err = nil;
        resultBlock(responseObject, err);
    };
    
    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(task, error);
    };
    
    if (requestType == RequestTypeGet) {
        [self.sessionManager GET:urlStr parameters:param progress:nil success:successBlock failure:failBlock];
    }else {
        [self.sessionManager POST:urlStr parameters:param progress:nil success:successBlock failure:failBlock];
    }
}

@end
