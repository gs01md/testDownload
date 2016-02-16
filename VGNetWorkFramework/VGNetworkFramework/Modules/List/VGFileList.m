//
//  VGFileList.m
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/15.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGFileList.h"
#import "VGCGCoreDataHelper.h"
#import "VGDownloadFilePath.h"
#import "VGNetworkFrameworkTools.h"


#define DOWNLOAD_DIR @"VGNetworkFrameworkDownload"

@implementation VGFileList


#pragma mark - interface

/**
 *  获取：根据一个url获取对应的文件路径，通过查询数据库
 *
 *  @param url ：下载的文件的url
 *
 *  @return :如果有，则返回文件路径
 */
- (NSString *) getFilePathWithUrl:(NSString *)url {
    
    NSString *path = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VGDownloadFilePath"];
    
    /**
     *  谓词过滤，task 的 字段 taskQueueId
     */
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"url = %@",url];
    
    [request setPredicate:filter];
    
    VGCGCoreDataHelper *coredata = [VGCGCoreDataHelper sharedManagerCenter];
    
    if (nil != coredata &&
        nil != coredata.context) {
        
        NSArray *array = [coredata.context executeFetchRequest:request error:nil];
        
        /**
         *  返回第一个即可，同一个url只能有同一个文件，但是有可能有多条记录（暂不处理）
         */
        for (VGDownloadFilePath *temp in array) {
            
            path = temp.path;
            
            break;
        }
        
    }

    
    return  path;
    
}

/**
 *  插入：下载完成后，把文件路径插入到数据库中
 *
 *  @param url ：下载的文件的url
 *
 *  @return :如果有，则返回文件路径
 */
- (void) insertFilePathWithUrl:(NSString *)url name:(NSString *)name {
    
    VGCGCoreDataHelper *coredata = [VGCGCoreDataHelper sharedManagerCenter];
    
    if (nil != coredata &&
        nil != coredata.context) {
        
        VGDownloadFilePath *path  = [NSEntityDescription insertNewObjectForEntityForName:@"VGDownloadFilePath" inManagedObjectContext:coredata.context];
        path.url = url;
        path.name = name;
        path.path = [self makeFilePathWithUrl:url name:name];
        
        //从内存保存到数据库
        [[VGCGCoreDataHelper sharedManagerCenter] saveContext];
    }
    
}


/**
 *  创建：根据url创建对应的文件路径
 *
 *  @param url ：下载的文件的url
 *
 *  @return :如果有，则返回文件路径
 */
- (NSString *) makeFilePathWithUrl:(NSString *)url name:(NSString *)name{
    
    NSString *path = nil;
    
    NSString *md5Name = [VGNetworkFrameworkTools stringByMD5:url];
    
    NSString *fileName = [md5Name stringByAppendingString:name];
    
    path = [self pathDownload];
    
    path = [path stringByAppendingString:fileName];
    
    return  path;
    
}


/**
 *  从数据库获取文件列表--该接口可能暂时用不到
 *  因为，不需要都加载进来，不要验证每个文件的有效性
 */
- (void) getFilesFromCoreData {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VGDownloadFilePath"];
    
    VGCGCoreDataHelper *coredata = [VGCGCoreDataHelper sharedManagerCenter];
    
    if (nil != coredata &&
        nil != coredata.context) {
        
        NSArray *array = [coredata.context executeFetchRequest:request error:nil];
        
        if (nil == self.m_fileList) {
            
            self.m_fileList = [NSMutableArray new];
        }
        
        for ( VGDownloadFilePath *temp in array) {
            
            //没有该文件时，则删除数据库数据
            if (![self checkFileExist:temp.path]) {
                
                [coredata.context deleteObject:temp];
                
            } else {
                
                [self.m_fileList addObject:temp];
            }
        }
        
        [coredata saveContext];
    }

}

/**
 *  校验列表中的文件是否存在手机中
 */
- (Boolean) checkFileExist:(NSString *) filePath {
    
    Boolean bExist = false;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        
        bExist = true;
    }

    
    return bExist;
    
}

#pragma mark - function

/**
 *  文件保存路径
 */
- (NSString *) pathDownload {
    
    NSString *path = nil;
    
    path = [self pathDocument] ;
    
    NSString *dir = DOWNLOAD_DIR;
    [VGNetworkFrameworkTools createDir:dir path:path];
    
    NSString *newPath = [path stringByAppendingPathComponent:dir];
    newPath = [newPath stringByAppendingString:@"/"];
    
    return newPath;
}

/**
 *  应用的文档目录
 */
- (NSString *) pathDocument {
    
    NSString *path = nil;
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    if (nil != documentsDirectoryURL) {
        
        path = documentsDirectoryURL.description;
    }
    
    return path;
}


@end
