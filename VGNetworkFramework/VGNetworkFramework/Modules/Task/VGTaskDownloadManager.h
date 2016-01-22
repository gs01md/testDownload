//
//  VGTaskDownloadManager.h
//  VGNetworkFramework
//
//  所有下载任务的管理类
//
//  实现功能:
//
//  * 根据“队列名”和“url” 创建/获取一个下载任务
//  *
//  * 根据“队列名”和“url” 重启一个下载任务
//  * 根据“队列名”和“url” 暂停一个下载任务
//  * 根据“队列名”和“url” 删除一个下载任务
//  *
//
//  注释：
//  * 引入“队列”，是为了让多个页面的下载任务同时处理，这样，就不会因为前面的任务多导致新页面任务一直在等待执行。
//
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGTaskDownload.h"
#import <Foundation/Foundation.h>

@interface VGTaskDownloadManager : NSObject
/**
 *  下载管理中心--单例
 *
 *  @return 实例对象
 */
+ (instancetype) sharedManagerCenter;

/**
 *  根据“队列名”和“url” 创建/获取/重启一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) downloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;


/**
 *  根据“队列名”和“url” 暂停一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) pauseDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;


/**
 *  根据“队列名”和“url” 删除一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 */
- (void) deleteDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;

@end