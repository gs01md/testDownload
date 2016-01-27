//
//  CoreDataHelper.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "CGCoreDataHelper.h"


@implementation CGCoreDataHelper

#define debug  1

#pragma mark - FILES

NSString *storeFilename = @"vg-download.sqlite";

#pragma mark - PATHS
- (NSString *)applicationDocumentsDirectory {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSURL *)applicationStoresDirectory {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]] URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory withIntermediateDirectories:YES attributes:nil error:&error]) {
            if (debug == 1) {
                NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
            }else{
                NSLog(@"FAILD to Create Stores directory:%@",error);
            }
            
        }
    }
    
    return storesDirectory;
}

- (NSURL *)storeURL {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

- (id)init {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    
    if (self = [super init]) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:_coordinator];
    }
    
    return self;
}


- (void)loadStore {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    
    if (_store) {return;}
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:nil error:&error];
    
    if (!_store) {
        NSLog(@"Failded to add store. Error: %@", error);
        abort();
    }else if (debug == 1){
        NSLog(@"Successfully add store: %@", _store);
    }
}

#pragma mark - setup

- (void)setupCoreData {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    
    [self loadStore];
}

#pragma mark - save

- (void)saveContext {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    
    if ([_context hasChanges]) {
        NSError *error;
        
        if ([_context save:&error]) {
            NSLog(@"_context save changes to persistent store.");
        }else{
            NSLog(@"Faild to save changes: %@.",error);
        }
    }else{
        NSLog(@"SKIPPED _context save ,there are no changes!");
    }
    
}
@end
