//
//  AlertHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "AlertHelper.h"

static AlertButtonTappedBlock buttonTappedHandler;

@implementation AlertHelper

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonTappedHandler) {
        buttonTappedHandler(buttonIndex);
        buttonTappedHandler = nil;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonTappedHandler) {
        buttonTappedHandler(buttonIndex);
        buttonTappedHandler = nil;
    }
}

+ (void)setButtonTappedHandler:(AlertButtonTappedBlock)handler {
    buttonTappedHandler = handler;
}

+ (instancetype)sharedHelper {
    static AlertHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[AlertHelper alloc] initPrivate];
    });
    return helper;
}

- (instancetype)initPrivate {
    self  = [super init];
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singlton"
                                   reason:@"use [AlertHelper sharedHelper]"
                                 userInfo:nil];
    return nil;
}

@end