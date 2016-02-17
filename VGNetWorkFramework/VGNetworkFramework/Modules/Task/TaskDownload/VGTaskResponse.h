//
//  VGTaskResponse.h
//  VGNetWorkFramework
//
//  当请求一个任务时，根据情况，会返回不同的信息。
//  如果已经下载过，则直接返回路径
//  如果没有下载过，则加入队列，等待执行
//
//  Created by Simon on 16/2/16.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VGTaskNetwork.h"


@interface VGTaskResponse : NSObject

/**
 *  已下载文件的路径
 */
@property (nonatomic, strong) NSString *m_filePath;


/**
 *  下载任务对象
 */
@property (nonatomic, strong) VGTaskNetwork *m_task;

@end
