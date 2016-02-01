//
//  CoreDataHelper.h
//  VGNetworkFramework
//  读写列表数据
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface VGCGCoreDataHelper : NSObject


@property (nonatomic, readonly) NSManagedObjectContext       *context;
@property (nonatomic, readonly) NSManagedObjectModel         *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore            *store;

+ (instancetype)sharedManagerCenter;

//- (void)setupCoreData;//初始化时自动加载

/**
 *  保存更改
 */
- (void)saveContext;

@end
