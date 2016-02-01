//
//  TaskQueue.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskQueue : NSManagedObject

@property (nonatomic,strong)NSArray<Task*> *m_arrayTask;

@end

NS_ASSUME_NONNULL_END

#import "TaskQueue+CoreDataProperties.h"
