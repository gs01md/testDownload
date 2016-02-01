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

@end