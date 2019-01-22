//
//  DJTodayFireVoiceCell.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJTodayFireVoiceCell.h"
#import "UIButton+WebCache.h"

@interface DJTodayFireVoiceCell ()

/** 声音标题 */
@property (weak, nonatomic) IBOutlet UILabel *voiceTitleLabel;
/** 声音作者 */
@property (weak, nonatomic) IBOutlet UILabel *voiceAuthorLabel;
/** 声音播放暂停按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
/** 声音排名标签 */
@property (weak, nonatomic) IBOutlet UILabel *sortNumLabel;
/** 声音下载按钮 */
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;


@property (nonatomic, assign) DJTodayFireVoiceCellState state;

@end

@implementation DJTodayFireVoiceCell

static NSString *const cellID = @"todayFireVoice";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DJTodayFireVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DJTodayFireVoiceCell" owner:nil options:nil].firstObject;
        [cell addObserver:cell forKeyPath:@"sortNumLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return cell;
}



- (IBAction)downLoad {
    if (self.state == DJTodayFireVoiceCellStateWaitDownload) {
        NSLog(@"下载");
    }
}

- (IBAction)playOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    NSLog(@"播放/暂停");
    
}


#pragma mark - setter
- (void)setState:(DJTodayFireVoiceCellState)state{
    _state = state;
    switch (state) {
        case DJTodayFireVoiceCellStateWaitDownload:
            NSLog(@"等待下载");
            break;
        case DJTodayFireVoiceCellStateDownloading:{
            NSLog(@"正在下载");
        }
            break;
        case DJTodayFireVoiceCellStateDownloaded:{
            NSLog(@"下载完成");
        }
            break;
        default:
            break;
    }
}

- (void)setVoiceM:(DJDownloadVoiceModel *)voiceM{
    _voiceM = voiceM;
    self.voiceTitleLabel.text = voiceM.title;
    self.voiceAuthorLabel.text = [NSString stringWithFormat:@"by %@", voiceM.nickname];
    
    [self.playOrPauseBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:voiceM.coverSmall]  forState:UIControlStateNormal];
    self.sortNumLabel.text = [NSString stringWithFormat:@"%zd", voiceM.sortNum];
}


#pragma mark - 私有方法
- (void)addRotationAnimation {
    [self removeRotationAnimation];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2.0);
    animation.duration = 10;
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
    [self.downLoadBtn.imageView.layer addAnimation:animation forKey:@"rotation"];
    
}

- (void)removeRotationAnimation {
    
    [self.downLoadBtn.imageView.layer removeAllAnimations];
    
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"sortNumLabel.text"]) {
        NSInteger sort = [change[NSKeyValueChangeNewKey] integerValue];
        switch (sort) {
            case 1:{
                self.sortNumLabel.textColor = [UIColor redColor];
            }
                break;
            case 2:{
                self.sortNumLabel.textColor = [UIColor orangeColor];
            }
                break;
            case 3:{
                self.sortNumLabel.textColor = [UIColor greenColor];
            }
                break;
            default:{
                self.sortNumLabel.textColor = [UIColor grayColor];
            }
                break;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.playOrPauseBtn.layer.masksToBounds = YES;
    self.playOrPauseBtn.layer.borderWidth = 3;
    self.playOrPauseBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.playOrPauseBtn.layer.cornerRadius = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"sortNumLabel.text"];
}
@end
