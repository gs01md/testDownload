//
//  VGListManager.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/19.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGListManager.h"

@implementation VGListManager


#pragma mark - create

static VGListManager *center = nil;
static NSString *strClass = @"VGListManager";

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
        center = (VGListManager *)strClass;
        center = [[VGListManager alloc] init];
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
            
            self.m_downloadList = [[VGDownloadList alloc] init];
            self.m_fileList     = [[VGFileList alloc] init];

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


#pragma mark - foundation


@end