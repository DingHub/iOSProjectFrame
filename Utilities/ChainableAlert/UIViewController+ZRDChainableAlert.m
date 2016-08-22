//
//  UIViewController+ZRDChainableAlert.m
//  ChainableAlert-OC
//
//  Created by admin on 16/8/12.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "UIViewController+ZRDChainableAlert.h"

static ZRDChainableAlert *chainableAlert;
@implementation UIViewController (ZRDChainableAlert)

- (instancetype)alert:(NSString *)title message:(NSString *)message {
    chainableAlert = [ZRDChainableAlert alert:title message:message];
    return self;
}
- (instancetype)actionSheet:(NSString *)title message:(NSString *)message {
    chainableAlert = [ZRDChainableAlert actionSheet:title message:message];
    return self;
}

- (ZRDControllerAlertButtonTitleReceiver)normalButton {
    __weak typeof (self) weakSelf = self;
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^UIViewController * (NSString * title) {
        weakAlert.normalButton(title);
        return weakSelf;
    };
}
- (ZRDControllerAlertButtonTitleReceiver)destructiveButton {
    __weak typeof (self) weakSelf = self;
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^UIViewController * (NSString *title) {
        weakAlert.destructiveButton(title);
        return weakSelf;
    };
}
- (ZRDControllerAlertButtonTitleReceiver)cancelButton {
    __weak typeof (self) weakSelf = self;
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^UIViewController * (NSString *title) {
        weakAlert.cancelButton(title);
        return weakSelf;
    };
}

- (ZRDControllerAlertButtonActionReceiver)handler {
    __weak typeof (self) weakSelf = self;
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^UIViewController * (ZRDAlertButtonAction action) {
        weakAlert.handler(action);
        return weakSelf;
    };
}

/**
 *  Add a textField to the alert, if is under iOS 8.0 or is action sheet, no use.
 */
- (ZRDControllerAlertTextFieldReceiver)textField {
    __weak typeof (self) weakSelf = self;
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^UIViewController * () {
        weakAlert.textField();
        return weakSelf;
    };
}

/**
 *  Config the textField, if is under iOS 8.0 or is action sheet, no use.
 */
- (ZRDControllerAlertTextFieldConfigReceiver)configurationHandler {
    __weak typeof (self) weakSelf = self;
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^UIViewController * (ZRDAlertTextFieldConfiguration configuration) {
        weakAlert.configurationHandler(configuration);
        return weakSelf;
    };
}

- (UIViewController *)show {
    chainableAlert.show(self);
    return self;
}
- (ZRDControllerAlertShowAnimationReceiver)animated {
    __weak typeof (self) weakSelf = self;
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^UIViewController * (BOOL animated) {
        weakAlert.animated(animated);
        return weakSelf;
    };
}
- (ZRDControllerSourceRectReceiver)sourceRect {
    __weak typeof (self) weakSelf = self;
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^UIViewController * (CGRect rect) {
        weakAlert.sourceRect(rect);
        return weakSelf;
    };
}
- (ZRDCompletionReceriver)completion {
    __weak typeof (chainableAlert) weakAlert = chainableAlert;
    return ^void (ZRDCompletion block) {
        weakAlert.completion(block);
    };
}

@end
