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
 .textField()
 .configrationHandler(^(UITextField *textField) {
    textField.placeholder = @"UserName";
 })
 .textField()
 .configrationHandler(^(UITextField *textField) {
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
typedef void (^ZRDAlertTextFieldConfigration)(UITextField *);
typedef ZRDChainableAlert * (^ZRDAlertTextFieldReceiver)();
typedef ZRDChainableAlert * (^ZRDAlertTextFieldConfigReceiver)(ZRDAlertTextFieldConfigration);
typedef ZRDChainableAlert * (^ZRDAlertAnimationReceiver)(BOOL);
typedef ZRDChainableAlert * (^ZRDSourceRectReceiver)(CGRect);
typedef void (^ZRDCompletion)();
typedef void (^ZRDCompletionReceriver)(ZRDCompletion);

/**
 *  Create alert, actually UIAlertView if the device is below iOS 8 or UIAlertController for iOS 8 and later
 */
+ (instancetype)alert:(NSString *)title message:(NSString *)message;

/**
 *  Create alert, actually UIActionSheet if the device is below iOS 8 or UIAlertController for iOS 8 and later
 */
+ (instancetype)actionSheet:(NSString *)title message:(NSString *)message;


/**
 *  Add a normal button to the alert
 */
- (ZRDAlertButtonTitleReceiver)normalButton;

/**
 *  Add a destructive button to the alert, we can add more than 1 for iOS 8 and later, BUT, if below iOS 8, this func will do nothing for alertView, and only one destructive button will added for actionSheet
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
 *  Add a textField to the alert, if is under iOS 8.0 or is action sheet, no use.
 */
- (ZRDAlertTextFieldReceiver)textField;

/**
 *  Config the textField, if is under iOS 8.0 or is action sheet, no use.
 */
- (ZRDAlertTextFieldConfigReceiver)configrationHandler;

/**
 *  Actually pass self as a weak point to the alert
 */
- (ZRDAlertShowReceiver)show;

/**
 *  If below iOS 8 , no use.
 */
- (ZRDAlertAnimationReceiver)animated;

/**
 *  If UIAlertController used, and style is action sheet, and device is iPad, we can set the source rect for the popover controller
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
