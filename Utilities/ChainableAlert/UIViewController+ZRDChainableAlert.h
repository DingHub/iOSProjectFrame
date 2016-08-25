//
//  UIViewController+ZRDChainableAlert.h
//  ChainableAlert-OC
//
//  Created by admin on 16/8/12.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZRDChainableAlert.h"


/**
 *  Add chainable use to show an alert.
 
 e.g.
 
 1.
 [self alert:@"Title" message:@"message"]
 .configTextField(^(UITextField *textField) {
    textField.placeholder = @"UserName";
 })
 .configTextField(^(UITextField *textField) {
    textField.placeholder = @"Password";
    textField.secureTextEntry = YES;
 })
 .normalButton(@"Login")
 .handler(^(ZRDChainableAlert *alert) {
    NSArray *textFields = alert.textFields;
    NSLog(@"\nUsername:%@\nPassword:%@", [textFields[0] text], [textFields[1] text]);
 })
 .cancelButton(@"cancel")
 .show
 .animated(YES)
 .completion(nil);
 
 2.
 [self actionSheet:@"Title" message:@"message"]
 .normalButton(@"normal1")
 .handler(^(ZRDChainableAlert *alert) {
    NSLog(@"normal1");
 })
 .normalButton(@"normal2")
 .normalButton(@"normal3")
 .destructiveButton(@"destructive1")
 .handler (^(ZRDChainableAlert *alert) {
    NSLog(@"destructive1");
 })
 .destructiveButton(@"destructive2")
 .cancelButton(@"cancel")
 .show
 .animated(YES)
 .completion(nil);
 
 */
@interface UIViewController (ZRDChainableAlert)

typedef UIViewController * (^ZRDControllerAlertButtonTitleReceiver)(NSString *);
typedef UIViewController * (^ZRDControllerAlertButtonActionReceiver)(ZRDAlertButtonAction);
typedef UIViewController * (^ZRDControllerAlertTextFieldConfigReceiver)(ZRDAlertTextFieldConfiguration);
typedef UIViewController * (^ZRDControllerAlertShowAnimationReceiver)(BOOL);
typedef UIViewController * (^ZRDControllerSourceRectReceiver)(CGRect);

/**
 *  Create UIAlertController with alertView style
 */
- (instancetype)alert:(NSString *)title message:(NSString *)message;
/**
 *  Create UIAlertController with actionSheet style
 */
- (instancetype)actionSheet:(NSString *)title message:(NSString *)message;

/**
 *  Add a normal button to the alert
 */
- (ZRDControllerAlertButtonTitleReceiver)normalButton;

/**
 *  Add a destructive button to the alert
 */
- (ZRDControllerAlertButtonTitleReceiver)destructiveButton;

/**
 *  Add a cancel button to the alert, the most number of cancel button is 1
 */
- (ZRDControllerAlertButtonTitleReceiver)cancelButton;

/**
 *  Add button action
 */
- (ZRDControllerAlertButtonActionReceiver)handler;

/**
 *  Add a textField to the alert and config it, if is action sheet, no use. If the config action is nil, a textField will also be added.
 */
- (ZRDControllerAlertTextFieldConfigReceiver)configTextField;

/**
 *  Actually pass self as a weak point to the alert
 */
- (UIViewController *)show;

/**
 *  
 */
- (ZRDControllerAlertShowAnimationReceiver)animated;

/**
 *  If the style is action sheet, and device is iPad, we can set the source rect for the popover controller
 */
- (ZRDControllerSourceRectReceiver)sourceRect;

/**
 *  Must be called, or the alert will not appear. Pass a block as a callback after the alert appeard, if nothing to do, just do like: completion(nil).
 */
- (ZRDCompletionReceriver)completion;

@end
