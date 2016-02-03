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

/**
 *  同步任务
 *  保存后，然后再获取一次
 */
-(void) sycnTaskArray{
    ;
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
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"taskQueueId = %@",[self objectID]];
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
    
    [self getTaskArrayFromCoreData];
    
    for (Task * temp in self.m_arrayTask) {
        if (temp.url == url) {
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    self.m_arrayTask = [[VGCGCoreDataHelper sharedManagerCenter].context executeFetchRequest:request error:nil];
    
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
- (NSArray<Task*> *) saveDataWithName:(NSString *)url {
    
    if (![self isExistTask:url]) {
        Task *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:[VGCGCoreDataHelper sharedManagerCenter].context];
        newItem.url = url;
        
        //从内存保存到数据库
        [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
    }
    
    return self.m_arrayTask;
    
}


@end
