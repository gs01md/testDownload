//
//  VGBaseTask.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGBaseTask.h"


@implementation VGBaseTask


/**
 *  初始化任务
 *
 *  @param strUrl 网络资源路径
 *
 *  @return 任务
 */
- (instancetype) initTaskAndStartwithUrl:(NSString *)strUrl{
    
    if (self = [super init]) {
        _m_strSourceUrl = strUrl;
    }
    
    return self;
    
}

#pragma mark - 功能
/**
 *  暂停任务
 */
- (void) taskPause {
    
}

/**
 *  重启任务
 */
- (void) taskRestart {
    
}

#pragma mark - 网络状态变化代理
/**
 *  网络状态变化
 *
 *  @param currentNetworkType 当前网络类型
 */
- (void) networkStatusWithNetworkType:(VGNETWORKTYPE)currentNetworkType{
    
}



@end
