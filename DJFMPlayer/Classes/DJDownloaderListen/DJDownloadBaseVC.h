//
//  DJDownloadBaseVC.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UITableViewCell *(^GetCellBlock)(UITableView *tableView,NSIndexPath *indexPath);
typedef void(^BindBlock)(UITableViewCell *cell,id model);


@interface DJDownloadBaseVC : UIViewController

- (void)setUpWithDataSource:(NSArray *)dataSource getCell:(GetCellBlock)cellBlock bind:(BindBlock)bindBlock;

@end

NS_ASSUME_NONNULL_END
