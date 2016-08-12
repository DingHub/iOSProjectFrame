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
 
 [self actionSheet:@"Title" message:@"message"]
 .normalButton(@"normal1")
 .handler(^{
    NSLog(@"normal1");
 })
 .normalButton(@"normal2")
 .normalButton(@"normal3")
 .destructiveButton(@"destructive1")
 .handler (^{
    NSLog(@"destructive1");
 })
 .destructiveButton(@"destructive2")
 .cancelButton(@"cancel")
 .show()
 .animated(YES)
 .completion(nil);
 
 */
@interface UIViewController (ZRDChainableAlert)

typedef UIViewController * (^ZRDControllerAlertButtonTitleReceiver)(NSString *);
typedef UIViewController * (^ZRDControllerAlertButtonActionReceiver)(ZRDAlertButtonAction);
typedef UIViewController * (^ZRDControllerAlertVoidReceiver)();
typedef UIViewController * (^ZRDControllerAlertShowAnimationReceiver)(BOOL);
typedef UIViewController * (^ZRDControllerSourceRectReceiver)(CGRect);

/**
 *  Create alert, actually UIAlertView if the device is below iOS 8 or UIAlertController for iOS 8 and later
 */
- (instancetype)alert:(NSString *)title message:(NSString *)message;
/**
 *  Create alert, actually UIActionSheet if the device is below iOS 8 or UIAlertController for iOS 8 and later
 */
- (instancetype)actionSheet:(NSString *)title message:(NSString *)message;

/**
 *  Add a normal button to the alert
 */
- (ZRDControllerAlertButtonTitleReceiver)normalButton;
/**
 *  Add a destructive button to the alert, we can add more than 1 for iOS 8 and later, BUT, if below iOS 8, this func will do nothing for alertView, and only one destructive button will added for actionSheet
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
 *  Actually pass self as a weak point to the alert
 */
- (ZRDControllerAlertVoidReceiver)show;

/**
 *  If below iOS 8 , no use.
 */
- (ZRDControllerAlertShowAnimationReceiver)animated;

/**
 *  If UIAlertController used, and style is action sheet, and device is iPad, we can set the source rect for the popover controller
 */
- (ZRDControllerSourceRectReceiver)sourceRect;

/**
 *  Must be called, or the alert will not appear. Pass a block as a callback after the alert appeard, if nothing to do, just do like: completion(nil).
 */
- (ZRDCompletionReceriver)completion;

@end
