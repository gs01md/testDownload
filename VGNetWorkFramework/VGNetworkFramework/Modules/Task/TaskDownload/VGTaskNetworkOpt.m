//
//  VGTaskNetworkOpt.m
//  VGNetWorkFramework
//
//  Created by Simon on 16/2/17.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "VGTaskNetworkOpt.h"
#import "VGListManager.h"

@interface VGTaskNetworkOpt(){
    
}

/**
 *  下载地址
 */
@property (nonatomic, strong, readonly) NSString *m_url;

/**
 *  队列名称
 */
@property (nonatomic, strong, readonly) NSString *m_queue;


@end


@implementation VGTaskNetworkOpt

/**
 *  任务操作类
 *
 *  @param strUrl 下载地址
 *  @param queue  队列
 *
 *  @return
 */
- (instancetype) initWithStrUrl:(NSString *)strUrl queue:(NSString *)queue {
    
    if (self = [super init]) {
        
        _m_url = strUrl;
        _m_queue = queue;
        
        [self initTimer];
    }
    
    return self;
}

/**
 *  检查文件路径：如果存在，则直接返回，否则，要加入任务队列
 *
 *  @param strUrl : 下载地址
 */
-(NSString *)checkPathExist:(NSString*) strUrl{
    
    NSString *path = [[VGListManager sharedManagerCenter].m_fileList getFilePathWithUrl:strUrl];
    
    if (nil != path) {
        
        if ([self.delegate respondsToSelector:@selector(successWithFilePath:)]) {
            
            [self.delegate successWithFilePath:path ];
        }
    }
    
    return path;
}


#pragma mark - 定时器
/**
 *  用于创建本实例后，如果对应的文件已经下载，则通过统一的代理方式返回文件路径
 */
-(void)initTimer{
    
    //执行时间
    NSTimeInterval timeInterval = 0.5;
    
    //定时器
    NSTimer   *showTimer = [NSTimer scheduledTimerWithTimeInterval:0.0
                                                            target:self
                                                          selector:@selector(handleTimer:)
                                                          userInfo:nil
                                                           repeats:NO];
    
    showTimer.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    
    
}

//触发事件
-(void)handleTimer:(NSTimer *)theTimer{
    
    [self checkPathExist:self.m_url];
    
}


@end
