//
//  VGTaskNetworkOpt.h
//  VGNetWorkFramework
//
//  该类是对VGTaskNetwork的封装，用于处理各种情况下的抛出信息，
//  oc不允许直接new  NSManagedObject类 VGTaskNetwork
//
//  Created by Simon on 16/2/17.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VGTaskNetwork.h"

/**
 *  抛出信息
 */
@protocol protocol_VGTaskNetworkOpt <NSObject>

/**
 *  成功后，抛出路径
 *
 *  @param path 路径
 */
- (void) successWithFilePath:(NSString *)path;

@end

@interface VGTaskNetworkOpt : NSObject

/**
 *  下载任务类
 */
@property (nonatomic, strong) VGTaskNetwork *m_taskNetwork;

/**
 *  抛出信息
 */
@property (nonatomic, assign) id<protocol_VGTaskNetworkOpt>delegate;

/**
 *  任务操作类
 *
 *  @param strUrl 下载地址
 *  @param queue  队列
 *
 *  @return
 */
- (instancetype) initWithStrUrl:(NSString *)strUrl queue:(NSString *)queue;

/**
 *  检查文件路径：如果存在，则直接返回，否则，要加入任务队列
 *
 *  @param strUrl : 下载地址
 */
-(NSString*) checkPathExist:(NSString*) strUrl;
@end
