//
//  ViewController.m
//  testDownLoad
//
//  Created by Simon on 16/1/15.
//  Copyright © 2016年 Simon. All rights reserved.
//
#import "ViewController.h"

#import <VGNetworkFramework/VGTaskDownloadManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self taskManager];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fundation
- (void) taskManager {
    [[VGTaskDownloadManager sharedManagerCenter] createDownloadTaskWithUrl:@"" queue:@""];
}

@end
