//
//  DJSegmentRightLeftBtn.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/22.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJSegmentRightLeftBtn.h"

@interface DJSegmentRightLeftBtn ()

@property (nonatomic, assign) CGFloat radio;

@end

@implementation DJSegmentRightLeftBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

-(CGFloat)radio {
    return 0.7;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, 0, contentRect.size.width * self.radio, contentRect.size.height);
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(contentRect.size.width * self.radio, 0, contentRect.size.width * ( 1 - self.radio - 0.2), contentRect.size.height);
    
}



@end
