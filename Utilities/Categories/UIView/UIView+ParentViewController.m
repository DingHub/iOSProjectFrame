//
//  UIView+ParentViewController.m
//  iOSProjectFrame
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "UIView+ParentViewController.h"

@implementation UIView (ParentViewController)

- (UIViewController *)parentViewController {
    UIResponder *parentResponder = self;
    while (parentResponder != nil) {
        parentResponder = [parentResponder nextResponder];
        if ([parentResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)parentResponder;
        }
    }
    return nil;
}

@end
