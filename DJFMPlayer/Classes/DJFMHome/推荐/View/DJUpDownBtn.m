//
//  DJUpDownBtn.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJUpDownBtn.h"

@interface DJUpDownBtn ()

@property (nonatomic, assign) CGFloat radio;

@end

@implementation DJUpDownBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}


-(void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    self.titleLabel.font = [UIFont systemFontOfSize:12];
}

-(CGFloat)radio {
    return 0.7;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, contentRect.size.height * self.radio, contentRect.size.width, contentRect.size.height * (1 - self.radio));
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * self.radio);
    
}

@end
