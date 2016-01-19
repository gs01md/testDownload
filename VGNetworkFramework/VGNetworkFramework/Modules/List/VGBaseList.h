//
//  VGBaseList.h
//  VGNetworkFramework
//  列表基类
//  使用 plist 封装
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGBaseList : NSObject
@property (nonatomic, strong, readonly) NSString *m_strPath;
@property (nonatomic, strong, readonly) NSString *m_strName;


/**
 *  创建一个plist管理类的实例
 *
 *  @param strName plist文件名称
 *  使用默认路径创建
 *
 *  @return plist管理类实例
 */
- (instancetype) initWithName:(NSString *)strName;


/**
 *  创建一个plist管理类的实例
 *
 *  @param strPath plist文件路径
 *  @param strName plist文件名称
 *
 *  @return plist管理类实例
 */
- (instancetype) initWithPath:(NSString *)strPath name:(NSString *)strName;

/**
 *  获取数据，同时如果不存在则创建，所以要在初始化时调用该函数
 */
- (NSDictionary *) getListData;

/**
 *  写入数据
 */
- (void) saveListWithDictionary:(NSDictionary *)dic;

@end
