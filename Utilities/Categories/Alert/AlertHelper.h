//
//  AlertHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertButtonTappedBlock)(NSInteger buttonIndex);

@interface UIApplication (ActionSheet) <UIActionSheetDelegate>
@end
@interface UIApplication (AlertView) <UIAlertViewDelegate>
@end

@interface AlertHelper : NSObject

+ (void)setButtonTappedHandler:(AlertButtonTappedBlock)handler;

/**
 *  Show an alert view with a call back block
 *  If the system version < 8.0, we will use UIAlertView , otherwise, UIAlertController
 *
 *  @param viewController
 *  @param title
 *  @param message
 *  @param destructiveTitle -If the system version < 8.0, this parameter will lose effictiveness
 *  @param cancelTitle
 *  @param otherTitles      
 *  @param block            -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
+ (void)showAlertViewForViewController:(UIViewController *)viewController
                                 title:(NSString *)title
                               message:(NSString *)message
                destructiveButtonTitle:(NSString *)destructiveTitle
                     cancelButtonTitle:(NSString *)cancelTitle
                     otherButtonTitles:(NSArray<NSString *> *)otherTitles
                   buttonTappedHandler:(AlertButtonTappedBlock)block;
/**
 *  Show an action sheet with a call back block
 *  If the system version < 8.0, we will use UIActionSheet , otherwise, UIAlertController
 *
 *  @param viewController
 *  @param title
 *  @param message          -If the system version < 8.0, this parameter will lose effictiveness
 *  @param destructiveTitle
 *  @param cancelTitle
 *  @param otherTitles
 *  @param block            -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
+ (void)showActionSheetForViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                 message:(NSString *)message
                  destructiveButtonTitle:(NSString *)destructiveTitle
                       cancelButtonTitle:(NSString *)cancelTitle
                       otherButtonTitles:(NSArray<NSString *> *)otherTitles
                     buttonTappedHandler:(AlertButtonTappedBlock)block;
/**
 *  Show an action sheet with a call back block at the bottom of viewController's view
 *  If the system version < 8.0, we will use UIActionSheet , otherwise, UIAlertController
 *
 *  @param viewController   -If the system version < 8.0, this parameter will lose effictiveness
 *  @param rect             -If is CGRectNull and the device is an iPad, the action sheet will be displayed from the bottom
 *  @param title
 *  @param message
 *  @param destructiveTitle
 *  @param cancelTitle
 *  @param otherTitles
 *  @param block            -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
+ (void)showActionSheetForViewController:(UIViewController *)viewController
                              sourceRect:(CGRect)rect
                                   title:(NSString *)title
                                 message:(NSString *)message
                  destructiveButtonTitle:(NSString *)destructiveTitle
                       cancelButtonTitle:(NSString *)cancelTitle
                       otherButtonTitles:(NSArray<NSString *> *)otherTitles
                     buttonTappedHandler:(AlertButtonTappedBlock)block;

@end
