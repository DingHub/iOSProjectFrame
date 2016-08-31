//
//  ViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "ViewController.h"
#import "HttpHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dLog(@"Hello world!");
    NSString *path = @"https://www.baidu.com";
    NSDictionary *pars = @{@"key": @"value",
                           @"num": @100};
    [HttpHelper requestWithMethod:GET absolutePath:path parameters:pars completion:^(NSError *error, id responseData) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
