//
//  VGEnumAll.h
//  VGNetworkFramework
//  本文件包含所有的枚举定义
//  Created by Simon on 16/1/15.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGEnumFile.h"
#import "VGEnumTask.h"


#ifndef VGEnumAll_h
#define VGEnumAll_h



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




#endif /* VGEnumAll_h */
