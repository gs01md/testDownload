//
//  EnumAll.h
//  VGNetworkFramework
//  本文件包含所有的枚举定义
//  Created by Simon on 16/1/15.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "EnumFile.h"

#ifndef EnumAll_h
#define EnumAll_h



/**
 *  网络类型
 */
typedef enum{
    /**
     *  无网络
     */
    VGNETWORKTYPE_NULL = 0,
    
    /**
     *  WIFI
     */
    VGNETWORKTYPE_WIFI,
    
    /**
     *  移动网络
     */
    VGNETWORKTYPE_PHONE,
}VGNETWORKTYPE;


/**
 *  任务处理方式
 */
typedef enum {
    
    /**
     *  暂停
     */
    VGNETWORKTYPE_CHANGE_HANDLETYPE_PAUSE,
    
    /**
     *  终止
     */
    VGNETWORKTYPE_CHANGE_HANDLETYPE_STOP,
    
    /**
     *  重新开始
     */
    VGNETWORKTYPE_CHANGE_HANDLETYPE_RESTART,
    
    /**
     *  继续
     */
    VGNETWORKTYPE_CHANGE_HANDLETYPE_CONTINUE,
}VGNETWORKTYPE_CHANGE_HANDLETYPE;

/**
 *  任务状态
 */
typedef enum {
    /**
     *  已创建，还未请求下载
     */
    TASK_STATUS_CREATED = 0,
    
    /**
     *  与服务器建立连接中...
     */
    TASK_STATUS_LINKING,
    
    /**
     *  下载中...
     */
    TASK_STATUS_DOWNLOADING,
    
    /**
     *  暂停中...
     */
    TASK_STATUS_PAUSING,
    
    /**
     *  任务完成
     */
    TASK_STATUS_FINISHED,
    
}TASK_STATUS;


#endif /* EnumAll_h */
