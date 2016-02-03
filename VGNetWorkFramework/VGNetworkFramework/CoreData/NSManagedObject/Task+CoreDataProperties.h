//
//  Task+CoreDataProperties.h
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/3.
//  Copyright © 2016年 Simon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *downSize;
@property (nullable, nonatomic, retain) NSNumber *fileTotalSize;
@property (nullable, nonatomic, retain) NSString *taskQueueId;
@property (nullable, nonatomic, retain) NSNumber *taskStatus;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSData *resumeData;

@end

NS_ASSUME_NONNULL_END
