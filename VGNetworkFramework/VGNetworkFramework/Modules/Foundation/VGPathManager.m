//
//  VGPathManager.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGPathManager.h"

#pragma mark - 创建实例

static VGPathManager *center = nil;
static NSString *strClass = @"VGPathManager";

@implementation VGPathManager

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
        center = (VGPathManager *)strClass;
        center = [[VGPathManager alloc] init];
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

#pragma mark - 实现功能

/**
 *  获取文档路径
 *
 *  @return 路径
 */
- (NSString *) getDocumentPath {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *strPath = [paths objectAtIndex:0];
    
    return strPath;
}

@end
