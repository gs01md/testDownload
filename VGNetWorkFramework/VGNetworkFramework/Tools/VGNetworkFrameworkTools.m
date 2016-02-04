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

@end
