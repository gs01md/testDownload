//
//  VGDownloadList.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/26.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGDownloadList.h"

@implementation VGDownloadList

/**
 *  创建一个plist管理类的实例
 *
 *  @param strPath plist文件路径
 *  @param strName plist文件名称
 *
 *  @return plist管理类实例
 */
- (instancetype) init{
    
    if (self = [super init]) {
        
        [self getTaskQueueArrayFromCoreData];
    } 
    return self;
}

#pragma mark - interface

/**
 *  添加某个队列的某个任务
 *
 *  @param strQueue   队列名称
 *  @param strUrl     任务url
 */
- (VGTaskNetwork *) addTaskWithQueue:(NSString *)strQueue url:(NSString *)strUrl {
    
    VGTaskNetwork *task = nil;
    
    //如果数据库不存在 Task Queue，则保存到 数据库
    [self saveQueueToCoreDataWithName:strQueue];
    
    //获取 Task Queue
    TaskQueue *queue = [self getTaskQueue:strQueue];
    
    if (nil != queue) {
        
        task = [queue saveTaskAndGetTaskWithUrl:strUrl resume:nil];
        
    }
    
    return task;
    
}

/**
 *  根据“队列名”和“url” 重启一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) restartDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    
    //获取 下载任务
    VGTaskDownload *taskDownload = [self findDownloadTaskWithUrl:strUrl queue:strQueue];
    
    if (nil != taskDownload) {
        [taskDownload taskRestart];
    }
    
    return taskDownload;
    
}


/**
 *  根据“队列名”和“url” 暂停一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) pauseDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    
    //获取 下载任务
    VGTaskDownload *taskDownload = [self findDownloadTaskWithUrl:strUrl queue:strQueue];
    
    if (nil != taskDownload) {
        [taskDownload taskPause];
    }
    
    return taskDownload;

}


/**
 *  根据“队列名”和“url” 删除一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 */
- (void) deleteDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    
    //暂停任务
    [self pauseDownloadTaskWithUrl:strUrl queue:strQueue];
    
    //删除临时文件
    
    //删除数据库任务
    
    //删除队列中的该任务
    
}

/**
 *  根据“队列名”和“url” 查询一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 */
- (VGTaskDownload *) findDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    
    //获取 Task Queue
    TaskQueue *queue = [self getTaskQueue:strQueue];
    
    //获取 下载任务
    VGTaskNetwork *task = [queue saveTaskAndGetTaskWithUrl:strQueue resume:nil];
    
    return task.m_taskDownload;
}

/**
 *  获取某个任务的下载状态，如果有则返回，没有，则返回nil
 *
 *  @param name ：队列名称
 *  @param strUrl：任务url
 *  @return ：状态数据
 */
- (NSData *) getResumeDataWithQueue:(NSString *)strQueue url:(NSString *)strUrl {
    
    NSData * data = nil;
    
    TaskQueue * taskQueue = [self getTaskQueue:strQueue];
    
    if (nil != taskQueue) {
        
        data = [taskQueue getResumeDataWithUrl:strUrl];
        
    }
    
    return data;
}

/**
 *  保存某个任务的下载状态
 *
 *  @param strQueue   队列名称
 *  @param strUrl     任务url
 *  @param resumeData 下载状态
 */
- (void) saveResumeDataWithQueue:(NSString *)strQueue url:(NSString *)strUrl resume:(NSData *)resumeData {
    
    [self saveQueueToCoreDataWithName:strQueue];
    
    TaskQueue * taskQueue = [self getTaskQueue:strQueue];
    
    if (nil != taskQueue) {
        
        [taskQueue saveTaskAndGetTaskWithUrl:strUrl resume:resumeData];
    }
}

/**
 *  从数据库删除任务，并重新加载到队列里
 *
 *  @param strQueue   队列名称
 *  @param strUrl     任务url
 */
- (void) removeTaskWithQueue:(NSString *)strQueue url:(NSString *)strUrl {
    TaskQueue * taskQueue = [self getTaskQueue:strQueue];
    
    if (nil != taskQueue) {
        
        [taskQueue removeTaskWithUrl:strUrl];
        
    }
    
}


#pragma mark - function
/**
 *  从数据库获取 队列名称列表
 *  1. 当已有的m_arrayTaskQueue为空时，直接赋值，并获取每个队列的任务
 *  2. 当已有的m_arrayTaskQueue不为空时，则刚获取的数据，需要比对后，再进行赋值。
 */
- (NSArray<TaskQueue*> *) getTaskQueueArrayFromCoreData {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TaskQueue"];
    
    VGCGCoreDataHelper *coredata = [VGCGCoreDataHelper sharedManagerCenter];
    
    if (nil != coredata &&
        nil != coredata.context) {
        
        NSArray *array = [coredata.context executeFetchRequest:request error:nil];
        
        [self compareAndSyncQueueArray:array];
    }
    
    
    /**
     *  加载每个列表的任务
     */
    for (TaskQueue *temp in self.m_arrayTaskQueue) {
        
        [temp getTaskArrayFromCoreData];
    }
    
    return self.m_arrayTaskQueue;
    
}

/**
 *  数据库是否存在某个下载队列
 *
 *  @param queueName ：队列名称
 *
 *  @return ：YES 存在；NO 不存在
 */
- (Boolean) isExistTaskQueue:(NSString *) queueName{
    
    Boolean isExist = false;
    
    [self getTaskQueueArrayFromCoreData];
    
    for (TaskQueue *temp in self.m_arrayTaskQueue) {
        
        if ([[temp.name stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:[queueName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
            isExist = true;
            break;
        }
    }
    
    return isExist;
}

/**
 *  数据库是否存在某个下载队列
 *
 *  @param queueName ：队列名称
 *
 */
- (TaskQueue *) getTaskQueue:(NSString *) queueName{
    
    TaskQueue *taskQueue = nil;
    
    for (TaskQueue *temp in self.m_arrayTaskQueue) {
        
        if ([[temp.name stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:[queueName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
            
            taskQueue = temp;
            break;
        }
    }
    
    return taskQueue;
}


/**
 *  如果不存在 任务队列，则创建
 *
 *  @param name ：队列名称
 */
- (NSArray<TaskQueue*> *) saveQueueToCoreDataWithName:(NSString *)name {
    
    if (![self isExistTaskQueue:name]) {
        TaskQueue *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"TaskQueue" inManagedObjectContext:[VGCGCoreDataHelper sharedManagerCenter].context];
        newItem.name = name;
        
        //从内存保存到数据库
        [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
    }
    
    return [self getTaskQueueArrayFromCoreData];
    
}


#pragma mark - 数组比较
/**
 *  刚获取的队列和已有的队列进行比较
 *  如果m_arrayTaskQueue中没有，则添加并加载任务
 *
 *  @param array ：刚获取的队列
 */
- (void) compareAndSyncQueueArray:(NSArray *)array {
    
    if (nil == self.m_arrayTaskQueue) {
        
        self.m_arrayTaskQueue = [NSMutableArray new];
    }
    
    for (TaskQueue *temp in array) {
        
        //在现有的数组里查找是否已经有某个队列
        TaskQueue * queue = [self getTaskQueue:temp.name];
        
        if (nil == queue) {
            
            [self.m_arrayTaskQueue addObject:temp];
            [queue getTaskArrayFromCoreData];
            
        }else {
            
            [queue getTaskArrayFromCoreData];
        }
    }
}

@end
