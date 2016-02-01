//
//  VGDownloadList.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/26.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGDownloadList.h"

@implementation VGDownloadList

/**
 *  创建一个plist管理类的实例
 *
 *  @param strPath plist文件路径
 *  @param strName plist文件名称
 *
 *  @return plist管理类实例
 */
- (instancetype) init{
    
    if (self = [super init]) {
        [self getTaskArrayFromCoreData];
    }
    return self;
}

/**
 *  从数据库获取 队列名称列表
 */
- (void) getTaskArrayFromCoreData {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TaskQueue"];
    self.m_arrayTaskQueue = [[VGCGCoreDataHelper sharedManagerCenter].context executeFetchRequest:request error:nil];
    
    NSLog(@"%@",self.m_arrayTaskQueue);
}

@end
