//
//  ViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "ViewController.h"
#import "DeviceInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dLog(@"Hello world!");

    log(@"%@", [DeviceInfo platformForUser]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
