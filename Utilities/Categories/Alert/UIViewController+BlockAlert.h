//
//  UIViewController+BlockAlert.h
//  AlertHelper
//
//  Created by admin on 16/7/28.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertHelper.h"

@interface UIViewController (BlockAlert)

/**
 *  Show an alert view with a call back block
 *  If the system version < 8.0, we will use UIAlertView , otherwise, UIAlertController
 *
 *  @param title
 *  @param message
 *  @param destructiveTitle -If the system version < 8.0, this parameter will lose effictiveness
 *  @param cancelTitle
 *  @param otherTitles
 *  @param block            -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
        destructiveButtonTitle:(NSString *)destructiveTitle
             cancelButtonTitle:(NSString *)cancelTitle
             otherButtonTitles:(NSArray<NSString *> *)otherTitles
           buttonTappedHandler:(AlertButtonTappedBlock)block;

/**
 *  Show an action sheet with a call back block
 *  If the system version < 8.0, we will use UIActionSheet , otherwise, UIAlertController
 *
 *  @param title
 *  @param message          -If the system version < 8.0, this parameter will lose effictiveness
 *  @param destructiveTitle
 *  @param cancelTitle
 *  @param otherTitles
 *  @param block            -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
- (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
          destructiveButtonTitle:(NSString *)destructiveTitle
               cancelButtonTitle:(NSString *)cancelTitle
               otherButtonTitles:(NSArray<NSString *> *)otherTitles
             buttonTappedHandler:(AlertButtonTappedBlock)block;

/**
 *  Show an action sheet with a call back block at the bottom of viewController's view
 *  If the system version < 8.0, we will use UIActionSheet , otherwise, UIAlertController
 *
 *  @param rect             -If is CGRectNull and the device is an iPad, the action sheet will be displayed from the bottom
 *  @param title
 *  @param message
 *  @param destructiveTitle
 *  @param cancelTitle
 *  @param otherTitles
 *  @param block            -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
- (void)showActionSheetWithSourceRect:(CGRect)rect
                                title:(NSString *)title
                              message:(NSString *)message
               destructiveButtonTitle:(NSString *)destructiveTitle
                    cancelButtonTitle:(NSString *)cancelTitle
                    otherButtonTitles:(NSArray<NSString *> *)otherTitles
                  buttonTappedHandler:(AlertButtonTappedBlock)block;

@end
