//
//  TaskQueue.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "TaskQueue.h"
#import "VGCGCoreDataHelper.h"
#import "VGListManager.h"

@implementation TaskQueue

@synthesize m_arrayTask;

#pragma mark - interface


/**
 *  获取任务或创建任务，并重新加载到队列里
 *
 *  @param strUrl         任务url
 *  @param resumeData     任务状态数据
 */
- (VGTaskNetwork *) saveTaskAndGetTaskWithUrl:(NSString *)strUrl resume:(NSData *)resumeData {
    

    VGTaskNetwork *task = [self getTaskWithUrl:strUrl];
    
    if ( nil != task ) {
        
        task.m_queueName = self.name;
        
        if (nil != resumeData) {
            
            [task saveDataWithResume: resumeData];
        }
    }
    
    [self startTaskManager];
    
    
    return task;
}


/**
 *  从数据库删除任务，并重新加载到队列里
 *
 *  @param strUrl     任务url
 */
- (void) removeTaskWithUrl:(NSString *)strUrl {
    
    VGTaskNetwork * task = [self getTaskWithUrl:strUrl];
    
    if (nil != task) {
        
        [[VGCGCoreDataHelper sharedManagerCenter].context deleteObject:task];
        
        //从内存保存到数据库
        [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
    }
    
    [self getTaskArrayFromCoreData];
    
}

/**
 *  获取某个任务的下载状态，如果有则返回，没有，则返回nil
 *
 *  @param name ：队列名称
 *  @param strUrl：任务url
 *  @return ：状态数据
 */
- (NSData *) getResumeDataWithUrl:(NSString *)strUrl {
    
    NSData * data = nil;
    
    VGTaskNetwork * task = [self getTaskWithUrl:strUrl];
    
    if (nil != task) {
        
        data = task.resumeData;
        
    }
    
    return data;
}

#pragma mark - 任务启动管理

/**
 *  处理该队列中的所有的任务的启动逻辑
 *  根据顺序，依次启动任务中的正在等待的任务
 */
- (void) startTaskManager {
    
    if (false == [self hasDownloadingTask]) {
        
        for (VGTaskNetwork *temp in self.m_arrayTask) {
            
            if (TASK_STATUS_QUEUE == temp.m_taskStatus) {
                
                [temp start];
                break;
            }
        }
    }

}

- (Boolean) hasDownloadingTask {
    
    Boolean hasDownloading = false;
    
    for (VGTaskNetwork *temp in self.m_arrayTask) {
        
        if (TASK_STATUS_DOWNLOADING == temp.m_taskStatus) {
            hasDownloading = true;
            break;
        }
    }
    
    return hasDownloading;
}

#pragma mark - Task 代理
/**
 *  通常用于任务结束时，启动新的任务
 */
- (void) taskStatus:(TASK_STATUS)status taskId:(NSString *)taskId {
    
    if (TASK_STATUS_FINISHED == status) {
        
        [self deleteTaskFromArray:taskId];
        
        [self deleteTaskFromCoreData:taskId];
        
    }
    
    [self startTaskManager];
}

/**
 *  下载完成后，从数组中删除任务
 *
 *  @param taskId ：任务id
 */
- (void) deleteTaskFromArray:(NSString *)taskId {
    
    VGTaskNetwork *task = [self taskFindWithId:taskId];
    
    if (nil != task &&
        nil != self.m_arrayTask) {
        
        [self.m_arrayTask removeObject:task];
    }
}

/**
 *  下载完成后，从数据库中删除任务
 *
 *  @param taskId ：任务id
 */
- (void) deleteTaskFromCoreData:(NSString *)taskId {
    
    VGTaskNetwork *task = [self taskFindWithId:taskId];
    
    if (nil != task ) {
        
        [[VGCGCoreDataHelper sharedManagerCenter].context deleteObject:task];
        
        //从内存保存到数据库
        [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
    }
}


#pragma mark - function
/**
 *  从数据库获取 队列名称列表
 */
- (NSArray<VGTaskNetwork *> *) getTaskArrayFromCoreData {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VGTaskNetwork"];
    
    /**
     *  谓词过滤，task 的 字段 taskQueueId
     */
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"taskQueueId = %@",[self objectID].description];
    
    [request setPredicate:filter];
    
    NSArray *array = [[VGCGCoreDataHelper sharedManagerCenter].context executeFetchRequest:request error:nil];
    
    [self compareAddSyncTaskArray:array];
    
    return self.m_arrayTask;
    
}

/**
 *  根据名称，获取任务
 *
 *  @param url ：任务url
 *
 *  @return 任务
 */
- (VGTaskNetwork *) getTaskWithUrl:(NSString *)url {
    
    VGTaskNetwork * task = nil;
    
    /**
     *  如果不存在，则创建
     */
    if (nil == (task = [self taskWithUrl:url])) {
        
        [self saveTaskWithName:url];
        task = [self taskWithUrl:url];
    }
    
    return task;
    
}

/**
 *  数据库是否存在某个下载队列
 *
 *  @param queueName ：队列名称
 *
 *  @return ：YES 存在；NO 不存在
 */
- (VGTaskNetwork *) taskWithUrl:(NSString *) url {
    
    [self getTaskArrayFromCoreData];
    
    VGTaskNetwork * task = nil;
    
    for (VGTaskNetwork *temp in self.m_arrayTask) {
        
        if ([[temp.url stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:[url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
            
            task = temp;
            
            break;
        }
    }
    
    return task;
}

/**
 *  数据库是否存在某个下载队列
 *
 *  @param queueName ：队列名称
 *
 *  @return ：YES 存在；NO 不存在
 */
- (Boolean) isExistTask:(NSString *) url {
    
    Boolean isExist = false;
    
    for (VGTaskNetwork *temp in self.m_arrayTask) {
        
        if ([[temp.url stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:[url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
            
            isExist = true;
            break;
        }
    }
    
    return isExist;
}

/**
 *  根据任务的objectid ，获取任务
 *
 *  @param taskId ：队列id
 *
 *  @return ：
 */
- (VGTaskNetwork *) taskFindWithId:(NSString *) taskId {
    
    VGTaskNetwork * task = nil;
    
    for (VGTaskNetwork *temp in self.m_arrayTask) {
        
        if ([[temp objectID].description isEqualToString:taskId]) {
            
            task = temp;
            break;
        }
    }
    
    return task;
}


/**
 *  如果不存在 任务，则创建
 *
 *  @param name ：队列名称
 */
- (void) saveTaskWithName:(NSString *)url {
    
    /**
     *  不存在时，并不是在这里进行创建的，而是在获取的时候创建的。所以，理论上，不存在“不存在的情况”
     *  存在时，保存数据
     */
    if (![self isExistTask:url]) {
        
        VGTaskNetwork *task = [NSEntityDescription insertNewObjectForEntityForName:@"VGTaskNetwork" inManagedObjectContext:[VGCGCoreDataHelper sharedManagerCenter].context];
        task.url         = url;
        task.taskQueueId = [self objectID].description;
        
        
        NSLog(@"%@",task.taskQueueId);
        
        //从内存保存到数据库
        [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
        
    }
    
}


/**
 *  管理：启动队列中的一个任务
 *
 *  @param task ：任务信息
 */
- (void) startOneTask:(VGTaskNetwork *)task {
    
    if (nil != task) {
        [task start];
    }
    
}

#pragma mark - 数组比较
/**
 *  刚获取的队列和已有的队列进行比较，并同步信息
 *  如果m_arrayTask中没有，则添加并加载任务
 *
 *  @param array ：刚获取的队列
 */
- (void) compareAddSyncTaskArray:(NSArray *)array {
    
    if (nil == self.m_arrayTask) {
        
        self.m_arrayTask = [NSMutableArray new];
    }
    
    for (VGTaskNetwork *temp in array) {
        
        VGTaskNetwork * task = [self findTaskInArray:temp];
        
        if (nil == task) {
            task.m_taskStatus = TASK_STATUS_QUEUE;
            [self.m_arrayTask addObject:temp];
            
        }else {
            
        }
    }
}

/**
 *  在已有的Array里面，查找指定的队列
 *
 *  @param task ：刚从CoreData里获取的任务
 */
- (VGTaskNetwork *) findTaskInArray:(VGTaskNetwork *)task {
    
    VGTaskNetwork * taskFind = nil;
    
    for (VGTaskNetwork *temp in self.m_arrayTask) {
        
        if ([task.url isEqualToString:temp.url]) {
            
            taskFind = temp;
            break;
        }
    }
    
    return taskFind;
}


@end
