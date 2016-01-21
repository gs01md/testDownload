//
//  VGBaseList.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGBaseList.h"
#import "VGPathManager.h"

@implementation VGBaseList

/**
 *  创建一个plist管理类的实例
 *
 *  @param strPath plist文件路径
 *  @param strName plist文件名称
 *
 *  @return plist管理类实例
 */
- (instancetype) initWithPath:(NSString *)strPath name:(NSString *)strName{
    
    if (self = [super init]) {
        _m_strPath = strPath;
        _m_strName = strName;
        [self getListData];
    }
    return self;
}

/**
 *  创建一个plist管理类的实例
 *
 *  @param strName plist文件名称
 *  使用默认路径创建
 *
 *  @return plist管理类实例
 */
- (instancetype) initWithName:(NSString *)strName{
    
    if (self = [super init]) {
        _m_strPath = [[VGPathManager sharedManagerCenter] getDocumentPath];
        _m_strName = strName;
        [self getListData];
        
    }
    return self;
}

/**
 *  完整路径
 */
- (NSString *) getFilePath {
    return [_m_strPath stringByAppendingPathComponent:_m_strName];
}

/**
 *  获取数据，同时如果不存在则创建，所以要在初始化时调用该函数
 */
- (NSDictionary *) getListData {
    
    return [NSDictionary dictionaryWithContentsOfFile:[self getFilePath]];  //读取数据

}

/**
 *  写入数据
 */
- (void) saveListWithDictionary:(NSDictionary *)dic{
    [dic writeToFile:[self getFilePath] atomically:YES];
}
@end
