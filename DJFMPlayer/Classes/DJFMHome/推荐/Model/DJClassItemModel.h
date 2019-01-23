//
//  DJClassItemModel.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/23.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJClassItemModel : NSObject

@property (nonatomic, copy)  NSString *id;
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, assign)  BOOL isChecked;
@property (nonatomic, assign)  NSInteger orderNum;
@property (nonatomic, copy)  NSString *coverPath;
@property (nonatomic, assign)  BOOL selectedSwitch;
@property (nonatomic, assign)  BOOL isFinished;
@property (nonatomic, copy)  NSString *contentType;
@property (nonatomic, assign)  NSInteger categoryType;
@property (nonatomic, assign)  BOOL filterSupported;
@property (nonatomic, assign)  BOOL isPaid;

@end

NS_ASSUME_NONNULL_END
