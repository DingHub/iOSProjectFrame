//
//  UIActionSheet+block.m
//  iOSProjectFrame
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "UIActionSheet+block.h"

@implementation UIActionSheet (block)

+ (void)showInView:(UIView *)view
             title:(NSString *)title
  destructiveTitle:(NSString *)destructiveTitle
 cancelButtonTitle:(NSString *)cancelTitle
 otherButtonTitles:(NSArray<NSString *> *)otherTitles
buttonTappedHandler:(AlertButtonTappedBlock)block {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:title
                                  delegate:[UIApplication sharedApplication]
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:destructiveTitle
                                  otherButtonTitles:nil];
    [AlertHelper setButtonTappedHandler:block];
    for (NSString *title in otherTitles) {
        [actionSheet addButtonWithTitle:title];
    }
    [actionSheet showInView:view];
    
}

@end
