//
//  CoreDataHelper.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGCGCoreDataHelper.h"


static VGCGCoreDataHelper *center = nil;
static NSString *strClass = @"VGCGCoreDataHelper";

@implementation VGCGCoreDataHelper


#define debug  1

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

#pragma mark - create

/**
 *  管理中心
 *
 *  @return 实例对象
 */
+ (instancetype)sharedManagerCenter {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        /**
         *  这么做的原因是：在 init() 中会判断是否是本类，而不是子类
         */
        center = (VGCGCoreDataHelper *)strClass;
        center = [[VGCGCoreDataHelper alloc] init];
    });
    
    if (nil != center) {
        if (FALSE == [center cantUsedBySubClass]) {
            return nil;
        }
    }
    
    return center;
}

- (instancetype)init {
    
    NSString *string = (NSString *)center;
    if ([string isKindOfClass:[NSString class]] == YES && [string isEqualToString:strClass]) {
        
        self = [super init];
        if (self) {
            
            if (FALSE == [self cantUsedBySubClass]) {
                return nil;
            }
            
            [self initCoreData];
        }
        
        return self;
        
    } else {
        
        return nil;
    }
}

/**
 *  防止子类使用，如果是子类，则会是不同的名称
 */
- (BOOL) cantUsedBySubClass {
    
    NSString *classString = NSStringFromClass([self class]);
    if ([classString isEqualToString:strClass] == NO) {
        
        return  FALSE;
    }
    
    return  TRUE;
    
}

#pragma mark - 初始化
- (void)initCoreData {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    
    NSArray<NSBundle *> *bundles = [NSBundle allFrameworks];
    //NSArray<NSBundle *> *bundles = [[NSArray alloc] init];
    
    _model = [NSManagedObjectModel mergedModelFromBundles:bundles];
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
    
    [self loadStore];
    
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


#pragma mark - FILES

NSString *storeFilename = @"vg-download.sqlite";

#pragma mark - PATHS
/**
 *  数据库路径设置--总目录--Documents
 *
 *  @return
 */
- (NSString *)applicationDocumentsDirectory {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  数据库路径设置--目录名称
 *
 *  @return
 */
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

/**
 *  数据库路径设置--完整路径
 *
 *  @return
 */
- (NSURL *)storeURL {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'",self.class, NSStringFromSelector(_cmd));
    }
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

+ (NSBundle *)resourceBundle:(NSString *)bundleName{
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]; //显然这里你也可以通过其他的方式取得，总之找到bundle的完整路径即可。
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    return bundle;
}
@end
