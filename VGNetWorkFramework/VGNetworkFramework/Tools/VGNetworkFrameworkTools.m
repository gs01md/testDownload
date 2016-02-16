//
//  VGNetworkFrameworkTools.m
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/3.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGNetworkFrameworkTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation VGNetworkFrameworkTools


/**
 *  去掉字符串两边的空格
 */
+(NSString *) stringTrim:(NSString *)str {
    if (nil != str) {
        str = [str stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return str;
}

/**
 *  对字符串进行MD5加密
 */
+ (NSString *) stringByMD5:(NSString *)str{
    
    const char* strUTF8 = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(strUTF8, (CC_LONG)strlen(strUTF8), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    
    return ret;
}

/**
 *  在已知路径下，如果文件夹不存在，则创建新的文件夹
 *
 *  @param dirName 新文件夹名称
 *  @param path    路径
 *
 *  @return yes:创建成功，no:创建失败
 */
+ (BOOL) createDir:(NSString *)dirName path:(NSString *)path {
    
    BOOL succ = NO;
    
    if (nil != path &&
        nil != dirName) {
        
        NSString *imageDir = [NSString stringWithFormat:path, NSHomeDirectory(), dirName];
        
        BOOL isDir = NO;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
        
        /**
         *  给定的字符串是否是一个路径
         */
        if (YES == isDir) {
            
            /**
             *  该路径是否已经存在，如果存在，则返回true; 如果不存在，则创建，并返回创建是否成功
             */
            if (NO ==  existed ) {
                
                succ = [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
            }else {
                
                succ = YES;
            }
            
        }
    }
    
    return succ;
}

@end
