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

@property (nonatomic, strong) VGTaskDownload * m_down;
@end

@implementation ViewController

- (IBAction)startDownEvent:(id)sender {
    [self taskRestart];
}

- (IBAction)pauseDownEvent:(id)sender {
    [self taskPause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self taskManager];
    
    
}


- (void) taskPause {
    [self.m_down taskPause];
}

- (void) taskRestart {
    [self.m_down taskRestart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fundation
- (void) taskManager {
    self.m_down = [[VGTaskDownloadManager sharedManagerCenter] createDownloadTaskWithUrl:@"" queue:@""];
}

- (IBAction)startEvent:(id)sender {
}
@end
