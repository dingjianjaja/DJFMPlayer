//
//  DJCategoryModel.h
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/16.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJCategoryModel : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
