//
//  VGFileList.h
//  VGNetWorkFramework

//  已下载文件管理类

//  Created by Simon on 16/2/15.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGFileList : NSObject

@property (nonatomic, strong) NSMutableArray *m_fileList;

/**
 *  获取：根据一个url获取对应的文件路径，通过查询数据库
 *
 *  @param url ：下载的文件的url
 *
 *  @return :如果有，则返回文件路径
 */
- (NSString *) getFilePathWithUrl:(NSString *)url;

/**
 *  插入：下载完成后，把文件路径插入到数据库中
 *
 *  @param url ：下载的文件的url
 *
 *  @return :如果有，则返回文件路径
 */
- (NSString *) insertFilePathWithUrl:(NSString *)url name:(NSString *)name;

@end
