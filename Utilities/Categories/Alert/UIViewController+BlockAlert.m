//
//  UIViewController+BlockAlert.m
//  AlertHelper
//
//  Created by admin on 16/7/28.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "UIViewController+BlockAlert.h"
#import "UIAlertView+block.h"
#import "UIActionSheet+block.h"
#import "UIAlertController+block.h"

@implementation UIViewController (BlockAlert)

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
        destructiveButtonTitle:(NSString *)destructiveTitle
             cancelButtonTitle:(NSString *)cancelTitle
             otherButtonTitles:(NSArray<NSString *> *)otherTitles
           buttonTappedHandler:(AlertButtonTappedBlock)block {
    
    if ([UIDevice currentDevice].systemVersion.integerValue < 8) {
        [UIAlertView showWithTitle:title
                           message:message
                 cancelButtonTitle:cancelTitle
                 otherButtonTitles:otherTitles
               buttonTappedHandler:block];
    } else {
        [UIAlertController showWithStyle:UIAlertControllerStyleAlert
                       forViewController:self sourceRect:CGRectNull
                                   title:title message:message
                  destructiveButtonTitle:destructiveTitle
                       cancelButtonTitle:cancelTitle
                       otherButtonTitles:otherTitles
                     buttonTappedHandler:block];
    }
}

- (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
          destructiveButtonTitle:(NSString *)destructiveTitle
               cancelButtonTitle:(NSString *)cancelTitle
               otherButtonTitles:(NSArray<NSString *> *)otherTitles
             buttonTappedHandler:(AlertButtonTappedBlock)block {
    
    [self showActionSheetWithSourceRect:CGRectNull
                                  title:title
                                message:message
                 destructiveButtonTitle:destructiveTitle
                      cancelButtonTitle:cancelTitle
                      otherButtonTitles:otherTitles
                    buttonTappedHandler:block];
}


- (void)showActionSheetWithSourceRect:(CGRect)rect
                                title:(NSString *)title
                              message:(NSString *)message
               destructiveButtonTitle:(NSString *)destructiveTitle
                    cancelButtonTitle:(NSString *)cancelTitle
                    otherButtonTitles:(NSArray<NSString *> *)otherTitles
                  buttonTappedHandler:(AlertButtonTappedBlock)block {
    
    if ([UIDevice currentDevice].systemVersion.integerValue < 8) {
        [UIActionSheet showInView:self.view
                            title:title
                 destructiveTitle:destructiveTitle
                cancelButtonTitle:cancelTitle
                otherButtonTitles:otherTitles
              buttonTappedHandler:block];
    } else {
        [UIAlertController showWithStyle:UIAlertControllerStyleActionSheet
                       forViewController:self
                              sourceRect:rect title:title
                                 message:message
                  destructiveButtonTitle:destructiveTitle
                       cancelButtonTitle:cancelTitle
                       otherButtonTitles:otherTitles
                     buttonTappedHandler:block];
    }
}

@end
