//
//  VGEnumFile.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/18.
//  Copyright © 2016年 Simon. All rights reserved.
//

#ifndef VGEnumFile_h
#define VGEnumFile_h


/**
 *  文件类型
 */
typedef enum {
    /**
     *  文件类型
     */
    VGFILETYPE_UNKOWN = 0 ,//未知类型
    
    /**
     *  文件类型
     */
    VGFILETYPE_IMG ,//图片
    
    /**
     *  文件类型
     */
    VGFILETYPE_MEDIA ,//媒体
}VGFILETYPE;

/**
 *  文件保存方式
 */
typedef enum {
    /**
     *  本地
     */
    VGFILEPOSITIONTYPE_LOCAL = 0,
    
    /**
     *  缓存
     */
    VGFILEPOSITIONTYPE_CATCH,
    /**
     *  本地+缓存
     */
    VGFILEPOSITIONTYPE_BOTH,
}VGFILEPOSITIONTYPE;


#endif /* VGEnumFile_h */
