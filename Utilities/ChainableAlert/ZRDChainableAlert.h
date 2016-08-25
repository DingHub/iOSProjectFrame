//
//  ZRDChainableAlert.h
//  ChainableAlert-OC
//
//  Created by admin on 16/8/12.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Chainable use of alerts.
 
 e.g.
 
 1.
 [ZRDChainableAlert alert:@"Title" message:@"message"]
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
    NSLog(@"Username:%@\nPassword:%@", [textFields[0] text], [textFields[1] text]);
 })
 .cancelButton(@"cancel")
 .show(aViewController)
 .animated(YES)
 .completion(nil);
 
 2.
 [ZRDChainableAlert actionSheet:@"Title" message:@"message"]
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
 .show(aViewController)
 .animated(YES)
 .completion(nil);
 */


NS_CLASS_AVAILABLE_IOS(8_0) @interface ZRDChainableAlert : NSObject

typedef void(^ZRDAlertButtonAction)(ZRDChainableAlert *);
typedef ZRDChainableAlert * (^ZRDAlertButtonTitleReceiver)(NSString *);
typedef ZRDChainableAlert * (^ZRDAlertButtonActionReceiver)(ZRDAlertButtonAction);
typedef ZRDChainableAlert * (^ZRDAlertShowReceiver)(UIViewController *);
typedef void (^ZRDAlertTextFieldConfiguration)(UITextField *);
typedef ZRDChainableAlert * (^ZRDAlertTextFieldConfigReceiver)(ZRDAlertTextFieldConfiguration);
typedef ZRDChainableAlert * (^ZRDAlertAnimationReceiver)(BOOL);
typedef ZRDChainableAlert * (^ZRDSourceRectReceiver)(CGRect);
typedef void (^ZRDCompletion)();
typedef void (^ZRDCompletionReceriver)(ZRDCompletion);

/**
 *  Create UIAlertController with alertView style
 */
+ (instancetype)alert:(NSString *)title message:(NSString *)message;

/**
 *  Create UIAlertController with actionSheet style
 */
+ (instancetype)actionSheet:(NSString *)title message:(NSString *)message;

/**
 *  Add a normal button to the alert
 */
- (ZRDAlertButtonTitleReceiver)normalButton;

/**
 *  Add a destructive button to the alert
 */
- (ZRDAlertButtonTitleReceiver)destructiveButton;

/**
 *  Add a cancel button to the alert, the most number of cancel button is 1
 */
- (ZRDAlertButtonTitleReceiver)cancelButton;

/**
 *  Add button action
 */
- (ZRDAlertButtonActionReceiver)handler;

/**
 *  Add a textField to the alert and config it, if is action sheet, no use. If the config action is nil, a textField will also be added.
 */
- (ZRDAlertTextFieldConfigReceiver)configTextField;

/**
 *  Actually pass a UIViewController as a weak point to the alert
 */
- (ZRDAlertShowReceiver)show;

/**
 *
 */
- (ZRDAlertAnimationReceiver)animated;

/**
 *  If the style is action sheet, and device is iPad, we can set the source rect for the popover controller
 */
- (ZRDSourceRectReceiver)sourceRect;

/**
 *  Must be called, or the alert will not appear. Pass a block as a callback after the alert appeard, if nothing to do, just do like: completion(nil).
 */
- (ZRDCompletionReceriver)completion;

/**
 *  textFields added to the alert.
 */
@property (nonatomic, strong, readonly)NSArray<UITextField *> *textFields;

@end
