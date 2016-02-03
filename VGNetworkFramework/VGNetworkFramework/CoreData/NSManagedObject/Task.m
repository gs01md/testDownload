//
//  Task.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "Task.h"
#import "VGCGCoreDataHelper.h"
@implementation Task

-(void)fetchRequest{
    
}


/**
 *  如果不存在 任务，则创建
 *
 *  @param name ：队列名称
 */
- (void) saveDataWithResume:(NSData *) resumeData {

    self.resumeData = resumeData;
    
    //从内存保存到数据库
    [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
    
}


@end
