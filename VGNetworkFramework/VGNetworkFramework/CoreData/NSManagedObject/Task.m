//
//  Task.m
//  VGNetworkFramework
//
//  Created by Simon on 16/1/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "Task.h"
#import "VGCGCoreDataHelper.h"
@implementation Task

-(void)fetchRequest{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    NSArray *itemObjects = [[VGCGCoreDataHelper sharedManagerCenter].context executeFetchRequest:request error:nil];
}
@end
