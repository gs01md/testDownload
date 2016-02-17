//
//  VGTaskNetwork.m
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/17.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGTaskNetwork.h"
#import "VGCGCoreDataHelper.h"

@interface VGTaskNetwork ()<protocol_downloadTask>{
    
}

@end

@implementation VGTaskNetwork

@synthesize m_taskDownload;
@synthesize m_queueName;
@synthesize m_taskStatus;
@synthesize delegate;

/**
 *  如果不存在 任务，则创建
 *
 *  @param name ：队列名称
 */
- (void) saveDataWithResume:(NSData *) resumeData {
    
    self.resumeData = resumeData;
    
    //从内存保存到数据库
    [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
    
}

/**
 *  启动任务--逻辑
 */
- (void) start {
    
    if (nil != m_taskDownload) {
        
        [self restartTaskDownload];
        
    } else {
        
        m_taskDownload = [[VGTaskDownload alloc] initTaskAndStartwithUrl:self.url queue:self.m_queueName taskId:[self objectID].description];
        
        m_taskDownload.delegate = self;
    }
}


#pragma mark - function

/**
 *  继续任务--封装
 */
- (void) restartTaskDownload {
    
    //如果没有启动，则启动；如果已经启动，则不进行处理
    if (nil != self.m_taskDownload &&
        TASK_STATUS_PAUSING == self.m_taskStatus) {
        
        [self.m_taskDownload taskRestart];
    }
}

/**
 *  暂停任务--封装
 */
- (void) pauseTaskDownload {
    
    //如果没有启动，则启动；如果已经启动，则不进行处理
    if (nil != self.m_taskDownload &&
        TASK_STATUS_DOWNLOADING == self.m_taskStatus) {
        
        [self.m_taskDownload taskPause];
    }
}

#pragma mark - 下载代理
/**
 *  改变任务状态
 *
 *  @param status 任务状态
 *  @param taskId 任务id，当任务结束时，删除任务时使用
 */
- (void) taskStatus:(TASK_STATUS)status {
    
    self.m_taskStatus = status;
    
    if (TASK_STATUS_FINISHED == self.m_taskStatus ||
        TASK_STATUS_ERROR == self.m_taskStatus ||
        TASK_STATUS_PAUSING == self.m_taskStatus) {
        
        if ([self.delegate respondsToSelector:@selector(taskStatus:taskId:)]) {
            
            [self.delegate taskStatus:status taskId:[self objectID].description];
        }
    }
}

/**
 *  下载成功后抛出信息
 *
 *  @param strQueue    队列
 *  @param strUrl      下载url
 *  @param strFilePath 下载成功后的文件路径
 */
- (void) taskDidFinishedSuccessed:(NSString *)strQueue url:(NSString *)strUrl filePath:(NSString *)strFilePath {
    
    if ([self.delegate respondsToSelector:@selector(taskSuccess:)]) {
        
        [self.delegate taskSuccess:strFilePath];
    }
}

@end
