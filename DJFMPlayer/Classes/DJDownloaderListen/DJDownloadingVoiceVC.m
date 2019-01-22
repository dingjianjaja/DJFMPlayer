//
//  DJDownloadingVoiceVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJDownloadingVoiceVC.h"

@interface DJDownloadingVoiceVC ()<UITableViewDelegate>

@end

@implementation DJDownloadingVoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpWithDataSource:@[@"dces",@"丁健测试"] getCell:^UITableViewCell *(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        return cell;
    } bind:^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
        cell.textLabel.text = (NSString *)model;
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
