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
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskQueue : NSManagedObject

/**
 *  该队列中的任务
 */
@property (nonatomic,strong)NSArray<Task*> *m_arrayTask;

/**
 *  同步任务
 *  保存后，然后再获取一次
 */
-(void) sycnTaskArray;

/**
 *  从数据库获取 队列名称列表
 */
- (NSArray<Task *> *) getTaskArrayFromCoreData;


/**
 *  根据名称，获取任务
 *
 *  @param url ：任务url
 *
 *  @return 任务
 */
- (Task *) getTaskWithUrl:(NSString *)url;
@end

NS_ASSUME_NONNULL_END

#import "TaskQueue+CoreDataProperties.h"
