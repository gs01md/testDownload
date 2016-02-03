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

#pragma mark - function
/**
 *  从数据库获取 队列名称列表
 */
- (NSArray<TaskQueue*> *) getTaskQueueArrayFromCoreData {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TaskQueue"];
    self.m_arrayTaskQueue = [[VGCGCoreDataHelper sharedManagerCenter].context executeFetchRequest:request error:nil];
    
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
- (NSArray<TaskQueue*> *) saveDataWithName:(NSString *)name {
    
    if (![self isExistTaskQueue:name]) {
        TaskQueue *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"TaskQueue" inManagedObjectContext:[VGCGCoreDataHelper sharedManagerCenter].context];
        newItem.name = name;
        
        //从内存保存到数据库
        [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
    }
    
    return [self getTaskQueueArrayFromCoreData];
    
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
        Task * task = [taskQueue getTaskWithUrl:strUrl];
        
        if (nil != task) {
            data = task.resumeData;
        }
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
    
    TaskQueue * taskQueue = [self getTaskQueue:strQueue];
    
    if (nil != taskQueue) {
        Task * task = [taskQueue getTaskWithUrl:strUrl];
        
        if (nil != task) {
            
            [task saveDataWithResume: resumeData];
        }
    }
}


@end
