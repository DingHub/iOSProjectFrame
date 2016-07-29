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
*
*  @param style
*  @param viewController
*  @param rect             If is CGRectNull and the device is an iPad, the action sheet will be displayed from the bottom
*  @param title
*  @param message
*  @param destructiveTitle
*  @param cancelTitle
*  @param otherTitles
*  @param block            -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
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
