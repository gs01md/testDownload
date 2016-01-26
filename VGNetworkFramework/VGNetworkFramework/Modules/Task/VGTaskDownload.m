//
//  VGTaskDownload.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/21.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGTaskDownload.h"

@implementation VGTaskDownload
/**
 *  创建任务并启动
 *
 *  @param strUrl 网络资源路径
 */
- (instancetype) initTaskAndStartwithUrl:(NSString*)strUrl{
    
    if (self = [super init]) {
        
    }
    
    return self;
}

/**
 *  暂停任务
 */
-(void)taskPause{
    
}

/**
 *  重新开始任务
 */
-(void)taskRestart{
    
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
-(void)networkStatusWithNetworkType:(VGNETWORKTYPE)currentNetworkType{
    
}

@end
