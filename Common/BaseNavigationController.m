//
//  BaseNavigationController.m
//  iOSProjectFrame
//
//  Created by admin on 16/8/25.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Color.h"
#import "ImageHelper.h"

@interface BaseNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, getter = isDuringPushAnimation) BOOL duringPushAnimation;
@property (weak, nonatomic) id<UINavigationControllerDelegate> realDelegate;
@property (nonatomic, strong) NSArray<UIBarButtonItem *> *leftButtonItems;

@end

@implementation BaseNavigationController

- (NSArray<UIBarButtonItem *> *)leftButtonItems {
    if (_leftButtonItems == nil) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
        [backBtn setImage:[UIImage imageNamed:@"nav_Back"] forState:UIControlStateNormal];
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
#pragma mark Life circle.

- (void)dealloc {
    self.delegate = nil;
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.delegate) {
        self.delegate = self;
    }
    self.interactivePopGestureRecognizer.delegate = self;
    
    //custom navigation bar
    NSDictionary *titleAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHex:0x474747],
                                      NSFontAttributeName:[UIFont systemFontOfSize:15]
                                      };
    self.navigationBar.titleTextAttributes = titleAttributes;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [self.navigationBar setBackgroundImage:[ImageHelper imageFromColor:[UIColor colorWithHexString:@"bbeebb"] andSize:CGSizeMake( screenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [ImageHelper imageFromColor:[UIColor clearColor] andSize:CGSizeMake(screenWidth, 1)];
    
    __weak typeof (self) weakSelf = self;
    self.backButtonItemAction = ^{
        [weakSelf popViewControllerAnimated:YES];
    };
    
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self setLeftButtonToController:viewController];
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setLeftButtonToController:rootViewController];
    }
    return self;
}
- (void)setLeftButtonToController:(UIViewController *)viewController {
    NSArray *viewControllers = self.viewControllers;
    if ( viewControllers.count > 0 ) {
        if ( viewControllers[0] == viewController ) {
            viewController.navigationItem.leftBarButtonItems = nil;
        } else {
            viewController.navigationItem.leftBarButtonItems = self.leftButtonItems;
        }
    }
}

-(void)backButtonPress {
    if (self.backButtonItemAction) {
        self.backButtonItemAction();
    } else {
        [self popViewControllerAnimated:YES];
    }
}

#pragma mark UINavigationController

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate {
    self.realDelegate = delegate != self ? delegate : nil;
    [super setDelegate: delegate ? self : nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.duringPushAnimation = YES;
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSCAssert(self.interactivePopGestureRecognizer.delegate == self, @"BaseNavigationController won't work correctly if you change interactivePopGestureRecognizer's delegate.");
    self.duringPushAnimation = NO;
    if ([self.realDelegate respondsToSelector:_cmd]) {
        [self.realDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return self.viewControllers.count > 1 && !self.isDuringPushAnimation;
    } else {
        return YES;
    }
}

#pragma mark Delegate Forwarder

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [self.realDelegate respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [super methodSignatureForSelector:aSelector] ?: [(id)self.realDelegate methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    id delegate = self.realDelegate;
    if ([delegate respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:delegate];
    }
}

@end
