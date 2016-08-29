//
//  BaseViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "BaseViewController.h"
#import "ImageHelper.h"
#import "MyStyle.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSArray<UIBarButtonItem *> *leftButtonItems;

@end


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //custom back button. --if you want more customs, see BaseNavigationController.m
    [self makeCustomBackButton];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)makeCustomBackButton {
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 0 ) {
        if (viewControllers[0] != self ) {
            self.navigationItem.leftBarButtonItems = self.leftButtonItems;
        }
    }
}

- (NSArray<UIBarButtonItem *> *)leftButtonItems {
    if (_leftButtonItems == nil) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
        [backBtn setImage:[UIImage imageNamed:backButtonImageName] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonPress) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -18;
        _leftButtonItems = @[negativeSpacer, backNavigationItem];
    }
    return _leftButtonItems;
}


-(void)backButtonPress {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
