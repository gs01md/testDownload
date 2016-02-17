//
//  VGTaskDownload.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/21.
//  Copyright © 2016年 Simon. All rights reserved.
//
#import "VGNetworkStatus.h"
#import "VGTaskDownload.h"
#import <AFURLSessionManager.h>
#import "VGNetworkFrameworkTools.h"
#import "VGListManager.h"

@interface VGTaskDownload () {
    
}

@property(nonatomic , strong) NSURLSessionDownloadTask * m_sessionDownloadTask;

@end

@implementation VGTaskDownload

/**
 *  创建任务并启动
 *  根据url，要检测--数据库中是否已经有该数据
 *  @param strUrl 网络资源路径
 */
- (instancetype) initTaskAndStartwithUrl:(NSString *)strUrl queue:(NSString *)strQueue taskId:(NSString*)taskId{
    
    if (self = [super init]) {
        
        [self changeStatus:TASK_STATUS_DOWNLOADING];
        _m_strSourceUrl = strUrl;
        _m_taskId = taskId;
        
        /**
         *  队列名可以为空，因为有个默认队列
         */
        _m_queueName = [VGNetworkFrameworkTools stringTrim:strQueue];
        if (nil == _m_queueName) {
            
            _m_queueName = DEFUALT_QUEUE;
        }
        
        [VGNetworkStatus sharedManagerCenter];//测试网络状态变化...
        
        [self loadResumeDatafromCoreData];//加载断点下载数据
        
        [self taskStart];//开始下载
    }
    
    return self;
}

/**
 *  尝试从数据库里加载“继续数据”,然后赋值给 m_resumeData
 */
- (void) loadResumeDatafromCoreData {
    
    self.m_resumeData = [[VGListManager sharedManagerCenter].m_downloadList getResumeDataWithQueue:self.m_queueName url:self.m_strSourceUrl];
    
}

/**
 *  暂停任务
 */
- (void) taskPause {
    
    __weak typeof(self) weakSelf = self;
    
    [self.m_sessionDownloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        
        /**
         *  resumeData : 包含了继续下载的开始位置\下载的url
         */
        weakSelf.m_resumeData = resumeData;
        
        weakSelf.m_sessionDownloadTask = nil;
        
        [[VGListManager sharedManagerCenter].m_downloadList saveResumeDataWithQueue:weakSelf.m_queueName url:weakSelf.m_strSourceUrl resume:weakSelf.m_resumeData];
        
        [self changeStatus:TASK_STATUS_PAUSING];
    }];
}

/**
 *  继续下载任务
 */
- (void) taskRestart {
    
    [self changeStatus:TASK_STATUS_DOWNLOADING];
    
    /**
     *  如果“继续数据”为空，则要使用重新开始接口进行下载
     */
    if (nil == self.m_resumeData) {
        
        [self taskStart];
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    self.m_sessionDownloadTask = [manager downloadTaskWithResumeData:self.m_resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"task:%@; progress:%@",self.m_taskId,downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        NSLog(@"%@", documentsDirectoryURL);
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (nil != error) {
            NSLog(@"出错：response:%@;error:%@",response,error);
            
            [self changeStatus:TASK_STATUS_ERROR];
            
            [self faildDownload];
            
        } else {
            NSLog(@"成功：response:%@;error:%@",response,error);
            
            [self changeStatus:TASK_STATUS_FINISHED];
            
            [self successDownload:response.suggestedFilename];
        }
        
    }];
    
    
    [self.m_sessionDownloadTask resume];
    
    self.m_resumeData = nil;
}

/**
 *  从0开始下载任务
 */
- (void) taskStart {
    
    [self changeStatus:TASK_STATUS_DOWNLOADING];
    
    /**
     *  如果“继续数据”不为空，则要使用继续下载接口进行下载
     */
    if (nil != self.m_resumeData) {
        
        [self taskRestart];
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:self.m_strSourceUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /**
     *  初次下载
     *
     *  @param downloadProgress  下载过程
     *  @param destination       保存位置
     *  @param completionHandler 下载完成
     */
    self.m_sessionDownloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"task:%@; progress:%@",self.m_taskId,downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        NSLog(@"%@", documentsDirectoryURL.description);
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (nil != error) {
            
            NSLog(@"出错：response:%@;error:%@",response,error);
            
            [self changeStatus:TASK_STATUS_ERROR];
            
            [self faildDownload];
            
        } else {
            
            NSLog(@"成功：response:%@;error:%@",response,error);

            [self changeStatus:TASK_STATUS_FINISHED];
            
            [self successDownload:response.suggestedFilename];
            
        }
        
    }];
    
    [self.m_sessionDownloadTask resume];

}

/**
 *  记录下载进度
 *
 *  @param length下载长度的最大值
 *
 */
- (void) progressDownloadedLength:(double) length {
    
}

/**
 *  成功：完成下载之后的处理
 *  1. 删除数据库的记录
 *  2. 保存文件列表到数据库，并同步到内存文件列表中
 */
- (void) successDownload:(NSString *)name {
    
    /**
     *  处理任务队列
     */
    [[VGListManager sharedManagerCenter].m_downloadList removeTaskWithQueue:self.m_queueName url:self.m_strSourceUrl];
    
    /**
     *  处理文件列表
     */
    NSString *path = [[VGListManager sharedManagerCenter].m_fileList insertFilePathWithUrl:self.m_strSourceUrl name:name];
    
    
    if([self.delegate respondsToSelector:@selector(taskDidFinishedSuccessed:url:filePath:)]){
        
        //如果有，则调用它的实现
        [self.delegate taskDidFinishedSuccessed:self.m_queueName url:self.m_strSourceUrl filePath:path];
    }
}

/**
 *  失败：完成下载之后的处理
 *  1. 删除数据库的记录
 *  2. 保存文件列表到数据库，并同步到内存文件列表中
 */
- (void) faildDownload {
    
}

#pragma mark - 网络状态代理
/**
 *  状态变化时，根据代理中传入网络状态，任务可以进行相应的处理
 *
 *  @param currentNetworkType 当前的网络类型
 */
- (void) networkStatusWithNetworkType:(VGNETWORKTYPE)currentNetworkType {
    
}

#pragma mark - 抛出任务状态
/**
 *  改变任务的状态
 *
 *  @param status
 */
- (void) changeStatus:(TASK_STATUS) status {
    
    if([ self.delegate respondsToSelector:@selector(taskStatus:)]){
        
        [self.delegate taskStatus:status];
    }
}


#pragma mark - test
@end
