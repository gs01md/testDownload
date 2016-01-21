//
//  VGTaskExecutingInfo.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGTaskExecutingInfo : NSObject
/**
 *  文件总大小
 */
@property (nonatomic, assign) double m_dlFileSize;

/**
 *  完成的大小
 */
@property (nonatomic, assign) double m_dlFinishedSize;
@end
