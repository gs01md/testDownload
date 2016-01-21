//
//  VGTaskDownload.h
//  VGNetworkFramework

//  单个下载任务类

//  Created by Simon on 16/1/21.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGBaseFileInfo.h"
#import "VGNetworkStatus.h"
#import "VGTaskExecutingInfo.h"
#import <Foundation/Foundation.h>

/**
 *  任务代理
 */
@protocol protocol_downloadTask <NSObject>

/**
 *  任务下载中抛出信息
 *  可能是任务完成百分比...
 *  @param error 错误信息
 */
- (void) taskExecutingWithInfo:(VGTaskExecutingInfo *)executingInfo;

/**
 *  任务报错
 *
 *  @param error 错误信息
 */
- (void) taskDidFaildWithError:(NSError *)error;

/**
 *  任务正常结束
 */
- (void) taskDidFinishedSuccessed;

@end

@interface VGTaskDownload : NSObject<Protocol_VGNetworkStatus>

/**
 *  下载任务类型：上传 或 下载，暂时只有下载
 */
@property(nonatomic , assign , readonly) VGTASK_TYPE m_taskType;


/**
 *  下载文件网络路径
 */
@property(nonatomic , strong , readonly) NSString *m_strSourceUrl;

/**
 *  下载文件信息
 */
@property(nonatomic , strong) VGBaseFileInfo *m_fileInfo;

/**
 *  下载过程中的状态信息
 */
@property(nonatomic , strong) VGTaskExecutingInfo *m_fileExecutingInfo;

/**
 *  下载文件保存方式
 */
@property(nonatomic , assign) VGFILEPOSITIONTYPE m_saveType;

/**
 *  起始时间
 */
@property(nonatomic , strong) NSDate *m_dateStart;

/**
 *  结束时间
 */
@property(nonatomic , strong) NSDate *m_dateFinish;

/**
 *  任务代理
 */
@property(nonatomic , strong) id<protocol_downloadTask> m_protocol_baseTask;

/**
 *  创建任务并启动
 *
 *  @param strUrl 网络资源路径
 */
- (instancetype) initTaskAndStartwithUrl:(NSString*)strUrl;

/**
 *  暂停任务
 */
-(void)taskPause;

/**
 *  重新开始任务
 */
-(void)taskRestart;


@end
