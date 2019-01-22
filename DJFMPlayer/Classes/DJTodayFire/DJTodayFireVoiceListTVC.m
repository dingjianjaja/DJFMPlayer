//
//  DJTodayFireVoiceListTVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJTodayFireVoiceListTVC.h"
#import "DJDownloadVoiceModel.h"
#import "DJTodayFireVoiceCell.h"
#import "MJExtension.h"
#import "DJSessionManager.h"

#define kBaseUrl @"http://mobile.ximalaya.com/"

@interface DJTodayFireVoiceListTVC ()

@property (retain, nonatomic)NSArray<DJDownloadVoiceModel*> *voiceMs;
@property (retain, nonatomic)DJSessionManager *sessionManager;

@end

@implementation DJTodayFireVoiceListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 80;
    __weak typeof (self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,@"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{@"device": @"iPhone",
                            @"key": self.loadKey,
                            @"pageId": @"1",
                            @"pageSize": @"30"};
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        NSMutableArray <DJDownloadVoiceModel *>*voiceyMs = [DJDownloadVoiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        weakSelf.voiceMs = voiceyMs;
    }];
    
    
}

#pragma mark -setter
- (void)setVoiceMs:(NSArray<DJDownloadVoiceModel *> *)voiceMs{
    _voiceMs = voiceMs;
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.voiceMs.count;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJTodayFireVoiceCell *cell = [DJTodayFireVoiceCell cellWithTableView:tableView];
    DJDownloadVoiceModel *model = self.voiceMs[indexPath.row];
    model.sortNum = indexPath.row + 1;
    cell.voiceM = model;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DJDownloadVoiceModel *model = self.voiceMs[indexPath.row];
    NSLog(@"跳转到播放器界面进行播放%@",model.title);
}

#pragma mark - 懒加载
- (DJSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [[DJSessionManager alloc] init];
    }
    return _sessionManager;
}


@end
