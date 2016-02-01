//
//  Task.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSManagedObject

-(void)fetchRequest;

@end

NS_ASSUME_NONNULL_END

#import "Task+CoreDataProperties.h"
