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

@property (nonatomic, strong) VGTaskResponse * m_down;
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
    [self.m_down.m_task pauseTaskDownload];
}

- (void) taskRestart {
    [self.m_down.m_task restartTaskDownload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fundation
- (void) taskManager {
    self.m_down = [[VGTaskDownloadManager sharedManagerCenter] createDownloadTaskWithUrl:@"https://qd.myapp.com/myapp/qqteam/AndroidQQ/mobileqq_android.apk" queue:@"default"];
}

- (IBAction)startEvent:(id)sender {
}
@end
