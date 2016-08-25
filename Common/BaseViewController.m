//
//  BaseViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "BaseViewController.h"
#import "ImageHelper.h"

@interface BaseViewController ()

//  webView for dialing
@property (nonatomic, strong) UIWebView *dialWebView;

@end


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dialNumber:(NSString *)phoneNumber {
    // An interesting method to dial a number~
    NSString *string = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    [self.dialWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
}
- (UIWebView *)dialWebView {
    if (_dialWebView == nil) {
        _dialWebView = [UIWebView new];
        [self.view addSubview:_dialWebView];
    }
    return _dialWebView;
}

@end
