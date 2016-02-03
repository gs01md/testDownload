//
//  VGNetworkFrameworkTools.m
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/3.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGNetworkFrameworkTools.h"

@implementation VGNetworkFrameworkTools
+(NSString *) stringTrim:(NSString *)str {
    if (nil != str) {
        str = [str stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return str;
}
@end
