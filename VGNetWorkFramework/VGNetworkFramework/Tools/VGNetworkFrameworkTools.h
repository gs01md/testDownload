//
//  VGNetworkFrameworkTools.h
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/3.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGNetworkFrameworkTools : NSObject

/**
 *  去掉字符串两边的空格
 */
+ (NSString *) stringTrim:(NSString *)str;

/**
 *  对字符串进行MD5加密
 */
+ (NSString *) stringByMD5:(NSString *)str;

/**
 *  在已知路径下，如果文件夹不存在，则创建新的文件夹
 *
 *  @param dirName 新文件夹名称
 *  @param path    路径
 *
 *  @return yes:创建成功，no:创建失败
 */
+ (BOOL) createDir:(NSString *)dirName path:(NSString *)path;

@end
