//
//  DJRecommendDataTool.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJRecommendDataTool.h"
#import "MJExtension.h"
#import "DJSessionManager.h"
#import "DJFocusImageModel.h"

@interface DJRecommendDataTool ()

@property (retain, nonatomic)DJSessionManager *sessionManager;

@end

@implementation DJRecommendDataTool

singtonImplement(DJRecommendDataTool)

#pragma mark - 接口
- (void)getAdList:(void (^)(NSArray<DJAdPicModel *> * _Nonnull, NSError * _Nonnull))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v4/recommends"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"includeActivity": @(YES),
                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        NSArray *focusImageMs = [DJFocusImageModel mj_objectArrayWithKeyValuesArray:responseObject[@"focusImages"][@"list"]];
        
        NSMutableArray *adPicMs = [NSMutableArray array];
        for (DJFocusImageModel *focusImageM in focusImageMs) {
            DJAdPicModel *adPicM = [[DJAdPicModel alloc] init];
            adPicM.focusImageM = focusImageM;
            [adPicMs addObject:adPicM];
        }
        result(adPicMs, error);
        
        
    }];
}

- (void)getPicMenueList:(void (^)(NSArray<DJMenuModel *> * _Nonnull, NSError * _Nonnull))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        NSArray *menuePicMs = [DJMenuModel mj_objectArrayWithKeyValuesArray:responseObject[@"discoveryColumns"][@"list"]];
        result(menuePicMs, error);
    }];
}


#pragma mark - lazyloading
- (DJSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [[DJSessionManager alloc] init];
    }
    return _sessionManager;
}

@end
