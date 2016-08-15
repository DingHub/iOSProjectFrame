//
//  BaseTabelViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "BaseTabelViewController.h"
#import "UIViewController+ZRDChainableAlert.h"


@implementation BaseTabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createRefreshHeaderWithCallback:(void(^)())block {
    
}
- (void)createRefreshFooterWithCallback:(void(^)())block {
    
}

- (void)noMoreInfoAction {
    
    [self alert:@"没有更多信息了~" message:nil]
    .cancelButton(@"知道了")
    .show()
    .animated(YES)
    .completion(nil);
    
}

@end
