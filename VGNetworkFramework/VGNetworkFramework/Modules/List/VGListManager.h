//
//  VGListManager.h
//  VGNetworkFramework

//  创建一个单例，用于全局的列表管理

//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VGDownloadList.h"

@interface VGListManager : NSObject

/**
 *  下载信息列表
 */
@property (nonatomic, strong)VGDownloadList *m_downloadList;

/**
 *  列表管理中心
 *
 *  @return 实例对象
 */
+ (instancetype)sharedManagerCenter;

@end
