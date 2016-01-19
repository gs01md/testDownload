//
//  VGPathManager.h
//  VGNetworkFramework
//  功能：路径管理
//  采用单例模式
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGPathManager : NSObject
/**
 *  管理中心
 *
 *  @return 实例对象
 */
+ (instancetype)sharedManagerCenter;

/**
 *  获取文档路径
 *
 *  @return 路径
 */
- (NSString *) getDocumentPath;
@end
