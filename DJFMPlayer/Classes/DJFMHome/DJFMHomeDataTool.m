//
//  DJFMHomeDataTool.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/18.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJFMHomeDataTool.h"

@interface DJFMHomeDataTool ()

@property (retain, nonatomic)DJSessionManager *manager;

@end

@implementation DJFMHomeDataTool
singtonImplement(DJFMHomeDataTool);

- (void)getHomeTabs:(void (^)(NSArray<DJHomeTabModel *> * _Nonnull))resultBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v1/tabs"];
    NSDictionary *param = @{
                            @"device": @"iPhone"
                            };
    
    [self.manager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        NSArray <NSDictionary *>*dicArray = (NSArray <NSDictionary *>*)responseObject[@"tabs"][@"list"];
        NSMutableArray *menueItems = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            
            [menueItems addObject:dic[@"title"]];
            
        }
        resultBlock(menueItems);
        
    }];
}


#pragma mark - 懒加载
- (DJSessionManager *)manager{
    if (!_manager) {
        _manager = [[DJSessionManager alloc] init];
    }
    return _manager;
}

@end
