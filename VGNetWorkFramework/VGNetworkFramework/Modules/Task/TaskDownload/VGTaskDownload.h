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

@optional
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
 *
 *  @param strFilePath 抛出下载后的文件路径
 */
- (void) taskDidFinishedSuccessed:(NSString *)strQueue url:(NSString *)strUrl filePath:(NSString*)strFilePath;

/**
 *  设置任务状态
 *
 *  @param status ：任务状态
 */
- (void) taskStatus:(TASK_STATUS)status;

@end

@interface VGTaskDownload : NSObject<Protocol_VGNetworkStatus>


/**
 *  下载任务类型：上传 或 下载，暂时只有下载
 */
@property(nonatomic , assign, readonly) VGTASK_TYPE m_taskType;

/**
 *  所属队列名称
 */
@property(nonatomic , strong, readonly) NSString *m_queueName;

/**
 *  下载文件网络路径
 */
@property(nonatomic , strong, readonly) NSString *m_strSourceUrl;

/**
 *  任务在数据库中id
 */
@property(nonatomic , strong) NSString * m_taskId;

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
 *  下载暂停数据
 */
@property(nonatomic , strong) NSData *m_resumeData;

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
@property(nonatomic , strong) id<protocol_downloadTask> delegate;

/**
 *  创建任务并启动
 *
 *  @param strUrl 网络资源路径
 */
- (instancetype) initTaskAndStartwithUrl:(NSString*)strUrl queue:(NSString *)strQueue taskId:(NSString*)taskId;

/**
 *  暂停任务
 */
-(void)taskPause;

/**
 *  重新开始任务
 */
-(void)taskRestart;

/**
 *  记录下载进度
 *
 *  @param length下载长度的最大值
 *
 */
- (void) progressDownloadedLength:(double) length;


@end
