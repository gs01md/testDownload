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
@property (nonatomic, strong) NSArray<TaskQueue *> *m_arrayTaskQueue;

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