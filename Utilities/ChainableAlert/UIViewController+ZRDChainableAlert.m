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
    return ^UIViewController * (NSString * title) {
        chainableAlert.normalButton(title);
        return self;
    };
}
- (ZRDControllerAlertButtonTitleReceiver)destructiveButton {
    return ^UIViewController * (NSString *title) {
        chainableAlert.destructiveButton(title);
        return self;
    };
}
- (ZRDControllerAlertButtonTitleReceiver)cancelButton {
    return ^UIViewController * (NSString *title) {
        chainableAlert.cancelButton(title);
        return self;
    };
}

- (ZRDControllerAlertButtonActionReceiver)handler {
    return ^UIViewController * (ZRDAlertButtonAction action) {
        chainableAlert.handler(action);
        return self;
    };
}

/**
 *  Add a textField to the alert, if is under iOS 8.0 or is action sheet, no use.
 */
- (ZRDControllerAlertTextFieldReceiver)textField {
    return ^UIViewController * () {
        chainableAlert.textField();
        return self;
    };
}

/**
 *  Config the textField, if is under iOS 8.0 or is action sheet, no use.
 */
- (ZRDControllerAlertTextFieldConfigReceiver)configrationHandler {
    return ^UIViewController * (ZRDAlertTextFieldConfigration configration) {
        chainableAlert.configrationHandler(configration);
        return self;
    };
}

- (ZRDControllerAlertVoidReceiver)show {
    return ^UIViewController * () {
        chainableAlert.show(self);
        return self;
    };
}
- (ZRDControllerAlertShowAnimationReceiver)animated {
    return ^UIViewController * (BOOL animated) {
        chainableAlert.animated(animated);
        return self;
    };
}
- (ZRDControllerSourceRectReceiver)sourceRect {
    return ^UIViewController * (CGRect rect) {
        chainableAlert.sourceRect(rect);
        return self;
    };
}
- (ZRDCompletionReceriver)completion {
    return ^void (ZRDCompletion block) {
        chainableAlert.completion(block);
    };
}

@end
