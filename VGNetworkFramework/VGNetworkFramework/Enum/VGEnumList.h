//
//  VGEnumList.h
//  VGNetworkFramework
//  缓存列表类型
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#ifndef VGEnumList_h
#define VGEnumList_h

/**
 列表类型
 */
typedef enum {
    /**
     *  默认类型
     */
    VGLISTTYPE_DEFAULT = 0,
    
    /**
     *  文件列表
     */
    VGLISTTYPE_FILE,
    
    /**
     *  下载任务列表
     */
    VGLISTTYPE_DOWNLOAD,
    
    /**
     *  上传任务列表
     */
    VGLISTTYPE_UPLOAD,
    
    /**
     *  缓存列表
     */
    VGLISTTYPE_CATCH,
}VGLISTTYPE;

#endif /* VGEnumList_h */
