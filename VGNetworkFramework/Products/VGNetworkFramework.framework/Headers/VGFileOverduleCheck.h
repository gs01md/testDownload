//
//  VGFileOverduleCheck.h
//  VGNetworkFramework
//  检测已下载的文件是否已过期
//  Created by Simon on 16/1/18.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VGBaseFileInfo.h"

@interface VGFileOverduleCheck : NSObject
+ (BOOL) fileOverDuleCheckWithFileInfo:(VGBaseFileInfo*)fileInfo;
@end
