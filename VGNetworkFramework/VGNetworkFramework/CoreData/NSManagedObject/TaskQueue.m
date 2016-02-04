//
//  TaskQueue.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "TaskQueue.h"
#import "VGCGCoreDataHelper.h"

@implementation TaskQueue

@synthesize m_arrayTask;

#pragma mark - interface


/**
 *  获取任务或创建任务，并重新加载到队列里
 *
 *  @param strUrl         任务url
 *  @param resumeData     任务状态数据
 */
- (void) saveTaskWithUrl:(NSString *)strUrl resume:(NSData *)resumeData {
    
    Task * task = [self getTaskWithUrl:strUrl];
    
    if (nil != task) {
        
        [task saveDataWithResume: resumeData];
    }
    
}

/**
 *  从数据库删除任务，并重新加载到队列里
 *
 *  @param strUrl     任务url
 */
- (void) removeTaskWithUrl:(NSString *)strUrl {
    
    Task * task = [self getTaskWithUrl:strUrl];
    
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
    
    Task * task = [self getTaskWithUrl:strUrl];
    
    if (nil != task) {
        
        data = task.resumeData;
        
    }
    
    return data;
}

#pragma mark - function
/**
 *  从数据库获取 队列名称列表
 */
- (NSArray<Task *> *) getTaskArrayFromCoreData {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    
    /**
     *  谓词过滤，task 的 字段 taskQueueId
     */
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"taskQueueId = %@",[self objectID].description];
    
    [request setPredicate:filter];
    
    self.m_arrayTask = [[VGCGCoreDataHelper sharedManagerCenter].context executeFetchRequest:request error:nil];
    
    return self.m_arrayTask;
    
}

/**
 *  根据名称，获取任务
 *
 *  @param url ：任务url
 *
 *  @return 任务
 */
- (Task *) getTaskWithUrl:(NSString *)url {
    
    Task * task = nil;
    
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
- (Task *) taskWithUrl:(NSString *) url {
    
    [self getTaskArrayFromCoreData];
    
    Task * task = nil;
    
    for (Task *temp in self.m_arrayTask) {
        
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
    
    for (Task *temp in self.m_arrayTask) {
        
        if ([[temp.url stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:[url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
            isExist = true;
            break;
        }
    }
    
    return isExist;
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
        
        Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:[VGCGCoreDataHelper sharedManagerCenter].context];
        task.url         = url;
        task.taskQueueId = [self objectID].description;
        
        
        NSLog(@"%@",task.taskQueueId);
        
        //从内存保存到数据库
        [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
        
    }
    
}


@end
