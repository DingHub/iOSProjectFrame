//
//  AlertHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "AlertHelper.h"

static AlertButtonTappedBlock buttonTappedHandler;

@implementation UIApplication (AlertView)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonTappedHandler) {
        buttonTappedHandler(buttonIndex);
        buttonTappedHandler = nil;
    }
}

@end

@implementation UIApplication (ActionSheet)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonTappedHandler) {
        buttonTappedHandler(buttonIndex);
        buttonTappedHandler = nil;
    }
}

@end

@implementation AlertHelper

+ (void)setButtonTappedHandler:(AlertButtonTappedBlock)handler {
    buttonTappedHandler = handler;
}

@end