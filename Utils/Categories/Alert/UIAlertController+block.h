//
//  UIAlertController+block.h
//  iOSProjectFrame
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertHelper.h"

@interface UIAlertController (block)

/**
 *  @param block    -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
+ (void)showWithStyle:(UIAlertControllerStyle)style
    forViewController:(UIViewController *)viewController
                title:(NSString *)title
              message:(NSString *)message
destructiveButtonTitle:(NSString *)destructiveTitle
    cancelButtonTitle:(NSString *)cancelTitle
    otherButtonTitles:(NSArray<NSString *> *)otherTitles
  buttonTappedHandler:(AlertButtonTappedBlock)block;
/**
 *  @param block    -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
+ (void)showWithStyle:(UIAlertControllerStyle)style
    forViewController:(UIViewController *)viewController
           sourceRect:(CGRect)rect
                title:(NSString *)title
              message:(NSString *)message
destructiveButtonTitle:(NSString *)destructiveTitle
    cancelButtonTitle:(NSString *)cancelTitle
    otherButtonTitles:(NSArray<NSString *> *)otherTitles
  buttonTappedHandler:(AlertButtonTappedBlock)block;

@end
