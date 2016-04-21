//
//  BaseWebViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/30.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] init];
    self.view = _webView;
    self.webView.delegate = self;
    if (_urlString) {
        _urlString = [_urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.navigationItem.title == nil) {
        self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

@end
