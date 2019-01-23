//
//  DJMenuView.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJMenuView.h"
#import "DJUpDownBtn.h"
#define kMenueWidth 60
#define kMenueMargin 20

@implementation DJMenuView

-(void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.menueModels.count;
    CGFloat h = self.frame.size.height;
    for(int i = 0; i < count; i++)
    {
        UIView *subView = self.subviews[i];
        subView.frame = CGRectMake(i * (kMenueWidth + kMenueMargin) + kMenueMargin, 0, kMenueWidth, h);
    }
    
    self.contentSize = CGSizeMake((kMenueWidth + kMenueMargin) * count + kMenueMargin, 0);
}

#pragma mark - setter
- (void)setMenueModels:(NSArray<id<DJMenuModelProtocol>> *)menueModels{
    _menueModels = menueModels;
    
    // 1. 移除所有之前的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger count = menueModels.count;
    for(int i = 0;i < count; i++)
    {
        id<DJMenuModelProtocol> model= menueModels[i];
        DJUpDownBtn *btn = [[DJUpDownBtn alloc] init];
        if (self.loadBlock) {
            self.loadBlock(btn, [NSURL URLWithString:model.imageURL]);
        }
        [btn setTitle:model.title forState:UIControlStateNormal];
        btn.tag = self.subviews.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        
    }
    
    [self setNeedsLayout];
}

#pragma mark - 私有方法
- (void)btnClick: (DJUpDownBtn *)upDownBtn {
    
    NSInteger tag = upDownBtn.tag;
    id<DJMenuModelProtocol> menueModel = self.menueModels[tag];
    if(menueModel.clickBlock != nil)
    {
        menueModel.clickBlock();
    }
    
}



@end
