//
//  BaseViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "BaseViewController.h"
#import "ImageGenerator.h"

@interface BaseViewController ()

//  webView for dialing
@property (nonatomic, strong) UIWebView *dialWebView;

@end


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom some appearences like navigation bar and so no
    
    //navigation bar title
    NSDictionary *titleAttributes = @{
                                      NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#474747"],
                                      NSFontAttributeName:[UIFont systemFontOfSize:15]
                                      };
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributes];
    
    //navigation bar left back button
    if (self != self.navigationController.viewControllers[0]) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"nav_Back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonPress) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        if(([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)){
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -18;
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];
        } else {
            self.navigationItem.leftBarButtonItem = backNavigationItem;
        }
        
    }
    
    //set style of the line under the navigation bar
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [self.navigationController.navigationBar setBackgroundImage:[ImageGenerator imageFromColor:[UIColor colorWithHexString:@"bbeebb"] andFrame:CGRectMake(0, 0, screenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [ImageGenerator imageFromColor:[UIColor clearColor] andFrame:CGRectMake(0, 0, screenWidth, 1)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)backButtonPress {
    [self.navigationController popViewControllerAnimated:YES];
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
