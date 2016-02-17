//
//  VGTaskNetwork+CoreDataProperties.h
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/17.
//  Copyright © 2016年 Simon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VGTaskNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGTaskNetwork (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *downSize;
@property (nullable, nonatomic, retain) NSNumber *fileTotalSize;
@property (nullable, nonatomic, retain) NSData *resumeData;
@property (nullable, nonatomic, retain) NSString *taskQueueId;
@property (nullable, nonatomic, retain) NSNumber *taskStatus;
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END
