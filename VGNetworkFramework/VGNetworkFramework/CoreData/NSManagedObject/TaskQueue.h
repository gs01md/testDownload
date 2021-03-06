//
//  TaskQueue.h
//  VGNetworkFramework
//
//  路线图：
//  VGTaskdownloadManager--VGListManager--VGDownloadList--TaskQueue--Task
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VGTaskNetworkOpt.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskQueue : NSManagedObject

/**
 *  该队列中的任务
 */
@property (nonatomic,strong)NSMutableArray<VGTaskNetwork*> *m_arrayTask;

/**
 *  同步任务
 *  保存后，然后再获取一次
 */
//-(void) sycnTaskArray;

/**
 *  从数据库获取 队列名称列表
 */
- (NSArray<VGTaskNetwork *> *) getTaskArrayFromCoreData;

/**
 *  从数据库删除任务，并重新加载到队列里
 *
 *  @param strUrl     任务url
 */
- (void) removeTaskWithUrl:(NSString *)strUrl;

/**
 *  获取任务或创建任务，并重新加载到队列里
 *
 *  @param strUrl     任务url
 *  @param resumeData     任务状态数据
 */
- (VGTaskNetwork *) saveTaskAndGetTaskWithUrl:(NSString *)strUrl resume:(NSData  * _Nullable)resumeData;

/**
 *  获取某个任务的下载状态，如果有则返回，没有，则返回nil
 *
 *  @param name ：队列名称
 *  @param strUrl：任务url
 *  @return ：状态数据
 */
- (NSData *) getResumeDataWithUrl:(NSString *)strUrl;

/**
 *  管理：启动队列中的一个任务
 *
 *  @param task ：任务信息
 */
- (void) startOneTask:(VGTaskNetwork *)task;


@end

NS_ASSUME_NONNULL_END

#import "TaskQueue+CoreDataProperties.h"
