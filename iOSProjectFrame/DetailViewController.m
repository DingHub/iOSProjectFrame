//
//  DetailViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/8/26.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)backButtonPress {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
