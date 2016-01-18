//
//  VGFileOverduleCheck.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/18.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGFileOverduleCheck.h"

@implementation VGFileOverduleCheck


/**
 *  没有该文件，也视为过期；有文件，但是大小不同时，为过期文件，需要重新下载
 *
 *  @param fileInfo 包含文件的名称和大小等信息
 *
 *  @return
 */
+ (BOOL) fileOverDuleCheckWithFileInfo:(VGBaseFileInfo*)fileInfo{
    return NO;
}

@end
