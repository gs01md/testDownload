//
//  TaskQueue+CoreDataProperties.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TaskQueue.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskQueue (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
