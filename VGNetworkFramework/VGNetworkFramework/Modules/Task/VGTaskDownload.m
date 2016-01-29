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



@interface VGTaskDownload () {
    
}

@property(nonatomic , strong) NSURLSessionDownloadTask *m_sessionDownloadTask;

@end

@implementation VGTaskDownload
/**
 *  创建任务并启动
 *  根据url，要检测--数据库中是否已经有该数据
 *  @param strUrl 网络资源路径
 */
- (instancetype) initTaskAndStartwithUrl:(NSString*)strUrl{
    
    if (self = [super init]) {
        _m_strSourceUrl = strUrl;
        _m_strSourceUrl = @"https://qd.myapp.com/myapp/qqteam/AndroidQQ/mobileqq_android.apk";
        [VGNetworkStatus sharedManagerCenter];//测试网络状态变化...
        [self loadResumeDatafromCoreData];
        [self taskStart];
    }
    
    return self;
}

/**
 *  尝试从数据库里加载“继续数据”,然后赋值给 m_resumeData
 */
- (void) loadResumeDatafromCoreData {
    self.m_resumeData = nil;
}

/**
 *  暂停任务
 */
- (void) taskPause{
    __weak typeof(self) weakSelf = self;
    [self.m_sessionDownloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        /**
         *  resumeData : 包含了继续下载的开始位置\下载的url
         */
        weakSelf.m_resumeData = resumeData;
        weakSelf.m_sessionDownloadTask = nil;
    }];
}

/**
 *  继续下载任务
 */
- (void) taskRestart{
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
        NSLog(@"%@",downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (nil == error) {
            NSLog(@"response:%@;error:%@",response,error);
        } else {
            NSLog(@"完成");
        }
    }];
    
    
    [self.m_sessionDownloadTask resume];
    
    self.m_resumeData = nil;
}

/**
 *  从0开始下载任务
 */
- (void) taskStart{
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
        
        NSLog(@"%@",downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (nil == error) {
            NSLog(@"response:%@;error:%@",response,error);
        } else {
            NSLog(@"完成");
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
- (void) progressDownloadedLength:(double) length{
    
}


#pragma mark - 网络状态代理
/**
 *  状态变化时，根据代理中传入网络状态，任务可以进行相应的处理
 *
 *  @param currentNetworkType 当前的网络类型
 */
- (void) networkStatusWithNetworkType:(VGNETWORKTYPE)currentNetworkType{
    
}

#pragma mark - test
@end
