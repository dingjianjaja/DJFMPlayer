//
//  XMGFileTool.h
//  XMGDownLoader
//
//  Created by 小码哥 on 2017/1/8.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJFileTool : NSObject

/**
 文件是否存在

 @param filePath 文件路径
 @return 是否存在
 */
+ (BOOL)fileExists:(NSString *)filePath;

/**
 文件大小

 @param filePath 文件路径
 @return 文件大小
 */
+ (long long)fileSize:(NSString *)filePath;

/**
 移动一个文件,到另外一个文件路径中

 @param fromPath 从哪个文件
 @param toPath 目标文件位置
 */
+ (void)moveFile:(NSString *)fromPath toPath:(NSString *)toPath;

/**
 删除某个文件

 @param filePath 文件路径
 */
+ (void)removeFile:(NSString *)filePath;
@end
