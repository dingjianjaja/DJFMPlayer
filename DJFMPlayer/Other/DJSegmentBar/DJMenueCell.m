//
//  DJMenueCell.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/22.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJMenueCell.h"

@implementation DJMenueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor redColor];
    }else {
        self.backgroundColor = [UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:0.4];
    }
}
@end
