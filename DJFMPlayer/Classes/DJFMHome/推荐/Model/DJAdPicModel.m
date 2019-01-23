//
//  DJAdPicModel.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJAdPicModel.h"
#import "DJAdLoopProtocol.h"

@interface DJAdPicModel ()<DJAdLoopProtocol>

@end

@implementation DJAdPicModel

-(void)setFocusImageM:(DJFocusImageModel *)focusImageM
{
    _focusImageM = focusImageM;
    self.adImgURL = [NSURL URLWithString:_focusImageM.pic];
    
}

-(void)setLiveM:(DJLiveModel *)liveM {
    _liveM = liveM;
    self.adImgURL = [NSURL URLWithString:_liveM.coverPath];
}

-(void)setTuiguangM:(DJTuiguangModel *)tuiguangM
{
    _tuiguangM = tuiguangM;
    self.adImgURL = [NSURL URLWithString:_tuiguangM.cover];
}

-(void)setClassItemM:(DJClassItemModel *)classItemM
{
    _classItemM = classItemM;
    self.adImgURL = [NSURL URLWithString:_classItemM.coverPath];
}

@end
