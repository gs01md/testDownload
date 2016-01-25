//
//  VGEnumTask.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#ifndef VGEnumTask_h
#define VGEnumTask_h

/**
 *  任务类型
 */
typedef enum {
    
    /**
     *  未知
     */
    VGTASK_TYPE_UNKNOWN = 0,
    
    /**
     *  下载
     */
    VGTASK_TYPE_DOWNLOAD,
    
    /**
     *  上传
     */
    VGTASK_TYPE_UPLOAD,
    
}VGTASK_TYPE;


/**
 *  任务处理方式
 */
typedef enum {
    
    /**
     *  暂停
     */
    VGNETWORKTYPE_CHANGE_HANDLETYPE_PAUSE = 0,
    
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

#endif /* VGEnumTask_h */
