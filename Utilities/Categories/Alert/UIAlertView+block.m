//
//  UIAlertView+block.m
//  iOSProjectFrame
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "UIAlertView+block.h"

@implementation UIAlertView (block)

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelTitle
    otherButtonTitles:(NSArray<NSString *> *)otherTitles
  buttonTappedHandler:(AlertButtonTappedBlock)block {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:[AlertHelper sharedHelper]
                              cancelButtonTitle:cancelTitle
                              otherButtonTitles:nil];
    [AlertHelper setButtonTappedHandler:block];
    for (NSString *title in otherTitles) {
        [alertView addButtonWithTitle:title];
    }
    [alertView show];
    
}

@end
