//
//  VGNetworkStatus.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/15.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGNetworkStatus.h"

@implementation VGNetworkStatus
#pragma mark - create

static VGNetworkStatus *center = nil;
static NSString *strClass = @"VGNetworkStatus";

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
        center = (VGNetworkStatus *)strClass;
        center = [[VGNetworkStatus alloc] init];
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
            [self initStatus];
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

#pragma mark - 
/**
 *  初始化网络状态变化操作
 */
- (void) initStatus{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
         self.conn = [Reachability reachabilityForInternetConnection];
         [self.conn startNotifier];
}

/**
 *  网络变化处理
 */
- (void)networkStateChange{
    [self checkNetworkState];
}

/**
 *  网络变化处理
 */
- (void) checkNetworkState{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];

    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];

    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        // 有wifi
        [self postNetworkState:VGNETWORKTYPE_WIFI];
        NSLog(@"有wifi");

    } else if ([conn currentReachabilityStatus] != NotReachable) {
        // 没有使用wifi, 使用手机自带网络进行上网
        [self postNetworkState:VGNETWORKTYPE_PHONE];
        NSLog(@"使用手机自带网络进行上网");

    } else {
        // 没有网络
        [self postNetworkState:VGNETWORKTYPE_NULL];

        NSLog(@"没有网络");
    }
}

- (void) postNetworkState:(VGNETWORKTYPE)currentNetworkType{
    if([ self.delegate respondsToSelector:@selector(networkStatusWithNetworkType:)])
    {
        //send the delegate function with the amount entered by the user
        [self.delegate networkStatusWithNetworkType:currentNetworkType];
    }
}

@end
