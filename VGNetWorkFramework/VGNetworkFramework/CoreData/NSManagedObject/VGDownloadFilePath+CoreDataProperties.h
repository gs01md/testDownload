//
//  VGDownloadFilePath+CoreDataProperties.h
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/15.
//  Copyright © 2016年 Simon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VGDownloadFilePath.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGDownloadFilePath (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *path;

@end

NS_ASSUME_NONNULL_END
