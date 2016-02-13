//
//  VGTaskDownloadQueueManager.h
//  VGNetWorkFramework
//
//  负责管理下载队列
//
//  Created by WoodGao on 16/2/12.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGTaskDownloadQueueManager : NSObject

- (void) addTask:(NSString *)url;
- (void) deleteTask:(NSString *)url;
- (NSArray<NSString *> *) searchTask;

@end
