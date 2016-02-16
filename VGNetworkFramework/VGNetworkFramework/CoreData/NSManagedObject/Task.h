//
//  Task.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VGTaskDownload.h"


NS_ASSUME_NONNULL_BEGIN

@protocol protocol_task <NSObject>

@optional

/**
 *  当一个任务已经执行完成时，重新开始一个新的任务
 */
- (void) taskStatus:(TASK_STATUS)status taskId:(NSString*)taskId;

@end

@interface Task : NSManagedObject

/**
 *  所在队列名称
 */
@property (nonatomic, strong) NSString *m_queueName;

/**
 *  下载状态
 */
@property(nonatomic , assign) TASK_STATUS m_taskStatus;


/**
 *  下载任务
 */
@property (nonatomic, strong) VGTaskDownload *m_taskDownload;

/**
 *  下载完一个任务（或暂停等其它情况）后，开始一个新的任务
 */
@property (nonatomic, strong) id<protocol_task> delegate;

/**
 *  如果不存在 任务，则创建
 *
 *  @param name ：队列名称
 */
- (void) saveDataWithResume:(NSData *) resumeData;

/**
 *  启动任务
 */
- (void) start;

/**
 *  暂停任务--封装
 */
- (void) pauseTaskDownload;

/**
 *  继续任务--封装
 */
- (void) restartTaskDownload;

@end

NS_ASSUME_NONNULL_END

#import "Task+CoreDataProperties.h"
