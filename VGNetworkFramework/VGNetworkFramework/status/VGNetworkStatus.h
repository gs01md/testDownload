//
//  VGNetworkStatus.h
//  VGNetworkFramework
//
//  监测网络状态，并做出相应改变
//
//  Created by Simon on 16/1/15.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络状态变更代理
 */
@protocol Protocol_VGNetworkStatus<NSObject>

@required
/**
 *  状态变化时，根据代理中传入网络状态，任务可以进行相应的处理
 *
 *  @param task 当前的网络类型
 */
-(void)networkStatusWithNetworkType:(VGNETWORKTYPE)task;

@end





@interface VGNetworkStatus : NSObject
/**
 *  网络状态变化时的代理
 */
@property (nonatomic, assign) id<Protocol_VGNetworkStatus> delegate;

/**
 *  网速
 */
@property (nonatomic, assign) float m_speedNetwork;
@end
