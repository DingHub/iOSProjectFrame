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
#import "MyStyle.h"

@interface BaseNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, getter = isDuringPushAnimation) BOOL duringPushAnimation;
@property (weak, nonatomic) id<UINavigationControllerDelegate> realDelegate;

@end

@implementation BaseNavigationController

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
    
#pragma mark custom the navigation bar
    //  (It's better to custom the back button in BaseViewController, because you can override the button action in a single view controller. --see BaseViewController.m)
    
    //  Title
    self.navigationBar.titleTextAttributes = navigationBarTitleTextAttributes;
    //  Background and bottom line
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [self.navigationBar setBackgroundImage:[ImageHelper imageFromColor:navigationBarBackgroundColor andSize:CGSizeMake( screenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [ImageHelper imageFromColor:navigationBarShadowImageColor andSize:CGSizeMake(screenWidth, 1)];
    
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
    }
    return YES;
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
