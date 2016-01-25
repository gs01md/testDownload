//
//  Files+CoreDataProperties.h
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Files.h"

NS_ASSUME_NONNULL_BEGIN

@interface Files (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END
