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
     *  在排队中，等待下载
     */
    TASK_STATUS_QUEUE = 0,
    
    
    /**
     *  下载中...
     */
    TASK_STATUS_DOWNLOADING,
    
    /**
     *  暂停中...，暂停完了，只是加入队列，并不是立即下载
     */
    TASK_STATUS_PAUSING,
    
    /**
     *  任务完成
     */
    TASK_STATUS_FINISHED,
    
    /**
     *  任务出错
     */
    TASK_STATUS_ERROR,
    
}TASK_STATUS;

#endif /* VGEnumTask_h */
