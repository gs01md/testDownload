//
//  VGTaskDownloadManager.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGTaskDownloadManager.h"
#import "VGCGCoreDataHelper.h"

@implementation VGTaskDownloadManager

#pragma mark - create

static VGTaskDownloadManager *center = nil;
static NSString *strClass = @"VGTaskDownloadManager";

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
        center = (VGTaskDownloadManager *)strClass;
        center = [[VGTaskDownloadManager alloc] init];
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
            
            self.m_listManager = [VGListManager sharedManagerCenter];
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



#pragma mark - interface

/**
 *  根据“队列名”和“url” 创建一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) createDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    return [[VGTaskDownload alloc] initTaskAndStartwithUrl:@""];
}

/**
 *  根据“队列名”和“url” 重启一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) restartDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    return nil;
}

/**
 *  根据“队列名”和“url” 暂停一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (VGTaskDownload *) pauseDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    return nil;
}


/**
 *  根据“队列名”和“url” 删除一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 */
- (void) deleteDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    
}

/**
 *  根据“队列名”和“url” 查询一个下载任务
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 */
- (VGTaskDownload *) findDownloadTaskWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    return nil;
}

/**
 *  根据“队列名”和“url” 检查本地文件是否存在
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (BOOL) checkFileExistWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    return TRUE;
}

/**
 *  根据“队列名”和“url” 检查本地文件是否过期
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (BOOL) checkFileValidWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    return TRUE;
}

/**
 *  根据“队列名”和“url” 检查任务是否在任务列表中
 *
 *  @param strUrl   下载链接
 *  @param strQueue 下载队列名称--为自定义队列名称
 *
 *  @return 下载任务对象
 */
- (BOOL) checkTaskInQueueWithUrl:(NSString *)strUrl queue:(NSString *)strQueue {
    return TRUE;
}

/**
 *  保存更改到数据库
 */
- (void) saveChangeToCoreData {
    [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
}

@end
