//
//  DJNoDownloadView.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJNoDownloadView.h"

@interface DJNoDownloadView ()
@property (weak, nonatomic) IBOutlet UIImageView *noDataImageView;

@end

@implementation DJNoDownloadView

+ (instancetype)noDownloadView{
    NSBundle *currentBundle = [NSBundle mainBundle];
    DJNoDownloadView *noDataV = [currentBundle loadNibNamed:@"DJNoDownloadView" owner:nil options:nil].firstObject;
    return noDataV;
}

- (void)setNoDataImg:(UIImage *)noDataImg{
    _noDataImg = noDataImg;
    self.noDataImageView.image = noDataImg;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (IBAction)goAction:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
