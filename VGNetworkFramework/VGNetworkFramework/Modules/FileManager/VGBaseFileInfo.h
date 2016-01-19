//
//  VGBaseFileInfo.h
//  VGNetworkFramework
//  本类定义下载/上传文件的基本信息
//  Created by Simon on 16/1/18.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGBaseFileInfo : NSObject

/**
 *  上传/下载文件的  类型
 */
@property (nonatomic, assign) VGFILETYPE m_type;

/**
 *  上传/下载文件的  名称
 */
@property (nonatomic, strong) NSString *m_strName;

/**
 *  上传/下载文件的  大小
 */
@property (nonatomic, assign) double m_dlLength;

@end
