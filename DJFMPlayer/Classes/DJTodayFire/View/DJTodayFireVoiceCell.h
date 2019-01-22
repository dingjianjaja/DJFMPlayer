//
//  DJTodayFireVoiceCell.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJDownloadVoiceModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DJTodayFireVoiceCellState) {
    DJTodayFireVoiceCellStateWaitDownload,
    DJTodayFireVoiceCellStateDownloading,
    DJTodayFireVoiceCellStateDownloaded,
};

@interface DJTodayFireVoiceCell : UITableViewCell

@property (retain, nonatomic)DJDownloadVoiceModel *voiceM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
