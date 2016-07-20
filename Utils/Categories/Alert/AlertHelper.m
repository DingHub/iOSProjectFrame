//
//  AlertHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "AlertHelper.h"
#import "UIAlertView+block.h"
#import "UIActionSheet+block.h"
#import "UIAlertController+block.h"

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

+ (void)showAlertViewForViewController:(UIViewController *)viewController
                                 title:(NSString *)title
                               message:(NSString *)message
                destructiveButtonTitle:(NSString *)destructiveTitle
                     cancelButtonTitle:(NSString *)cancelTitle
                     otherButtonTitles:(NSArray<NSString *> *)otherTitles
                   buttonTappedHandler:(AlertButtonTappedBlock)block {
    if ([UIDevice currentDevice].systemVersion.integerValue < 8) {
        [UIAlertView showWithTitle:title message:message cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles buttonTappedHandler:block];
    } else {
        [UIAlertController showWithStyle:UIAlertControllerStyleAlert forViewController:viewController sourceRect:CGRectNull title:title message:message destructiveButtonTitle:destructiveTitle cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles buttonTappedHandler:block];
    }
}

+ (void)showActionSheetForViewController:(UIViewController *)viewController
                              sourceRect:(CGRect)rect
                                   title:(NSString *)title
                                 message:(NSString *)message
                  destructiveButtonTitle:(NSString *)destructiveTitle
                       cancelButtonTitle:(NSString *)cancelTitle
                       otherButtonTitles:(NSArray<NSString *> *)otherTitles
                     buttonTappedHandler:(AlertButtonTappedBlock)block {
    if ([UIDevice currentDevice].systemVersion.integerValue < 8) {
        [UIActionSheet showInView:viewController.view title:title destructiveTitle:destructiveTitle cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles buttonTappedHandler:block];
    } else {
        [UIAlertController showWithStyle:UIAlertControllerStyleActionSheet forViewController:viewController sourceRect:rect title:title message:message destructiveButtonTitle:destructiveTitle cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles buttonTappedHandler:block];
    }
    
}

+ (void)showActionSheetForViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                 message:(NSString *)message
                  destructiveButtonTitle:(NSString *)destructiveTitle
                       cancelButtonTitle:(NSString *)cancelTitle
                       otherButtonTitles:(NSArray<NSString *> *)otherTitles
                     buttonTappedHandler:(AlertButtonTappedBlock)block {
    if ([UIDevice currentDevice].systemVersion.integerValue < 8) {
        [UIActionSheet showInView:viewController.view title:title destructiveTitle:destructiveTitle cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles buttonTappedHandler:block];
    } else {
        [UIAlertController showWithStyle:UIAlertControllerStyleActionSheet forViewController:viewController title:title message:message destructiveButtonTitle:destructiveTitle cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles buttonTappedHandler:block];
    }    
}

+ (void)setButtonTappedHandler:(AlertButtonTappedBlock)handler {
    buttonTappedHandler = handler;
}
+ (AlertButtonTappedBlock)buttonTappedHandler {
    return buttonTappedHandler;
}

@end
