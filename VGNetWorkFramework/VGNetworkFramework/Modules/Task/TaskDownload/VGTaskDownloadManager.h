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
#import "VGFileOverduleCheck.h"
#import <Foundation/Foundation.h>
#import "VGListManager.h"
#import "VGTaskDownload.h"


@interface VGTaskDownloadManager : NSObject<protocol_downloadTask>

/**
 *  所有列表
 */
@property (nonatomic, strong) VGListManager *m_listManager;


/**
 *  所有任务
 */
@property (nonatomic, strong) NSMutableArray<VGTaskDownload *> * m_arrayTaskDownload;


/**
 *  下载管理中心--单例
 *
 *  @return 实例对象
 */
+ (instancetype) sharedManagerCenter;

/**
 *  根据“队列名”和“url” 创建一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) createDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;

/**
 *  根据“队列名”和“url” 重启一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) restartDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;


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


/**
 *  根据“队列名”和“url” 查询一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 */
- (VGTaskDownload *) findDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;

/**
 *  根据“队列名”和“url” 检查本地文件是否存在
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (BOOL) checkFileExistWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;

/**
 *  根据“队列名”和“url” 检查本地文件是否过期
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (BOOL) checkFileValidWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;

/**
 *  根据“队列名”和“url” 检查任务是否在任务列表中
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (BOOL) checkTaskInQueueWithUrl:(NSString *)strUrl queue:(NSString *)strQueue;

/**
 *  保存更改到数据库
 */
- (void) saveChangeToCoreData;

@end
