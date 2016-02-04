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

@end
