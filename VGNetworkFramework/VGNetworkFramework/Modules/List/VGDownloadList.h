//
//  VGDownloadList.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/26.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "TaskQueue.h"
#import "VGCGCoreDataHelper.h"

@interface VGDownloadList : NSObject

/**
 *  任务队列数组
 */
@property (nonatomic, strong) NSMutableArray<TaskQueue *> *m_arrayTaskQueue;


/**
 *  添加某个队列的某个任务
 *
 *  @param strQueue   队列名称
 *  @param strUrl     任务url
 */
- (Task *) addTaskWithQueue:(NSString *)strQueue url:(NSString *)strUrl;

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
 *  获取某个任务的下载状态，如果有则返回，没有，则返回nil
 *
 *  @param name ：队列名称
 *  @param strUrl：任务url
 *  @return ：状态数据
 */
- (NSData *) getResumeDataWithQueue:(NSString *)strQueue url:(NSString *)strUrl;

/**
 *  保存某个任务的下载状态
 *
 *  @param strQueue   队列名称
 *  @param strUrl     任务url
 *  @param resumeData 下载状态
 */
- (void) saveResumeDataWithQueue:(NSString *)strQueue url:(NSString *)strUrl resume:(NSData *)resumeData;

/**
 *  从数据库删除任务，并重新加载到队列里
 *
 *  @param strQueue   队列名称
 *  @param strUrl     任务url
 */
- (void) removeTaskWithQueue:(NSString *)strQueue url:(NSString *)strUrl;
@end