//
//  ZRDChainableAlert.m
//  ChainableAlert-OC
//
//  Created by admin on 16/8/12.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "ZRDChainableAlert.h"

NS_ENUM(NSInteger, AlertStyle) {
    AlertStyleAlert,
    AlertStyleActionSheet
};

@interface ZRDChainableAlert ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) enum AlertStyle style;

@property (nonatomic, strong) NSMutableArray<NSString *> *normaleTitles;
@property (nonatomic, strong) NSMutableArray<NSString *> *destructiveTitles;
@property (nonatomic, copy) NSString *cancelTitle;

@property (nonatomic, strong) NSMutableArray<ZRDAlertButtonAction> *normalActions;
@property (nonatomic, strong) NSMutableArray<ZRDAlertButtonAction> *destructiveActions;
@property (nonatomic, copy) ZRDAlertButtonAction cancelAction;
@property (nonatomic, strong) NSMutableArray<ZRDAlertTextFieldConfiguration> *textFieldConfigurations;

/**
 *  1-normal, 2-destructive, 3-cancel
 */
@property (nonatomic, assign) int buttonFlag;

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign) BOOL presentAnimated;
@property (nonatomic, assign) CGRect fromRect;

@property (nonatomic, strong, readwrite)NSArray<UITextField *> *textFields;

@end

@implementation ZRDChainableAlert

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(enum AlertStyle)style {
    
    self.title = title;
    self.message = message;
    self.style = style;
    
    self.fromRect = CGRectNull;
    
    return self;

}

+ (instancetype)alert:(NSString *)title message:(NSString *)message {
    return [[ZRDChainableAlert alloc] initWithTitle:title message:message style:AlertStyleAlert];
}
+ (instancetype)actionSheet:(NSString *)title message:(NSString *)message {
    return [[ZRDChainableAlert alloc] initWithTitle:title message:message style:AlertStyleActionSheet];
}


- (ZRDAlertButtonTitleReceiver)normalButton {
    [self fillEmptyButtonAction];
    self.buttonFlag = 1;
    __weak typeof (self) weakSelf = self;
    return ^ZRDChainableAlert * (NSString *title) {
        [weakSelf.normaleTitles addObject:title];
        return weakSelf;
    };
}

- (ZRDAlertButtonTitleReceiver)destructiveButton {
    [self fillEmptyButtonAction];
    self.buttonFlag = 2;
    __weak typeof (self) weakSelf = self;
    return ^ZRDChainableAlert * (NSString *title) {
        [weakSelf.destructiveTitles addObject:title];
        return weakSelf;
    };
}


- (ZRDAlertButtonTitleReceiver)cancelButton {
    self.buttonFlag = 3;
    __weak typeof (self) weakSelf = self;
    return ^ZRDChainableAlert * (NSString *title) {
        weakSelf.cancelTitle = title;
        return weakSelf;
    };
}

- (void)fillEmptyButtonAction {
    ZRDAlertButtonAction action = ^(ZRDChainableAlert *alert){};
    switch (self.buttonFlag) {
        case 1:
            [self.normalActions addObject:action];
            break;
        case 2:
            [self.destructiveActions addObject:action];
            break;
        case 3:
            self.cancelAction = action;
            break;
        default:
            break;
    }
}

- (ZRDAlertButtonActionReceiver)handler {
    __weak typeof (self) weakSelf = self;
    return ^ZRDChainableAlert * (ZRDAlertButtonAction action) {
        switch (weakSelf.buttonFlag) {
            case 1:
                [weakSelf.normalActions addObject:action];
                break;
            case 2:
                [weakSelf.destructiveActions addObject:action];
                break;
            case 3:
                weakSelf.cancelAction = action;
                break;
            default:
                break;
        }
        return weakSelf;
    };
}

- (ZRDAlertTextFieldConfigReceiver)configTextField {
    __weak typeof (self) weakSelf = self;
    return ^ZRDChainableAlert * (ZRDAlertTextFieldConfiguration configuration) {
        ZRDAlertTextFieldConfiguration action = configuration;
        if (action == nil) {
            action = ^(UITextField *textField){};
        }
        [weakSelf.textFieldConfigurations addObject:action];
        return weakSelf;
    };
}


- (ZRDAlertShowReceiver)show {
    
    __weak typeof (self) weakSelf = self;
    return ^ZRDChainableAlert * (UIViewController *viewController) {
        weakSelf.viewController = viewController;
        return weakSelf;
    };
}
- (ZRDAlertAnimationReceiver)animated {
    
    __weak typeof (self) weakSelf = self;
    return ^ZRDChainableAlert * (BOOL animated) {
        weakSelf.presentAnimated = animated;
        return weakSelf;
    };
}
- (ZRDSourceRectReceiver)sourceRect {
    
    __weak typeof (self) weakSelf = self;
    return ^ZRDChainableAlert * (CGRect rect) {
        weakSelf.fromRect = rect;
        return weakSelf;
    };
}
- (ZRDCompletionReceriver)completion {
    
    __weak typeof (self) weakSelf = self;
    return ^void (ZRDCompletion block)  {
        [weakSelf showWithViewController:weakSelf.viewController
                           souceRect:weakSelf.fromRect
                            animated:weakSelf.presentAnimated
                          completion:^{
                              if (block) {
                                  block();
                              }
                          }];
    };
    
}

- (void)showWithViewController:(UIViewController *)viewController
                     souceRect:(CGRect)rect
                      animated:(BOOL)animated
                    completion:(void(^)())block {
    
    UIAlertControllerStyle style = self.style==AlertStyleAlert ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.title message:self.message preferredStyle:style];
    
    NSInteger i = 0;
    
    for (NSString *title in self.normaleTitles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.normalActions[i](self);
        }];
        [alertController addAction:action];
        i ++;
    }
    
    i = 0;
    
    for (NSString *title in self.destructiveTitles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            self.destructiveActions[i](self);
        }];
        [alertController addAction:action];
        i ++;
    }
    
    if (self.cancelTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:self.cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (self.cancelAction) {
                self.cancelAction(self);
            }
        }];
        [alertController addAction:action];
    }
                                 
    for (ZRDAlertTextFieldConfiguration configuration in self.textFieldConfigurations) {
        [alertController addTextFieldWithConfigurationHandler:configuration];
    }
    self.textFields = alertController.textFields;
    
    UIViewController *controller = viewController;
    if (controller == nil) {
        controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    UIView *fromView = controller.view;
    alertController.popoverPresentationController.sourceView = fromView;
    CGSize size = fromView.bounds.size;
    if (CGRectEqualToRect(rect, CGRectNull)) {
        alertController.popoverPresentationController.sourceRect = CGRectMake(size.width * 0.5, size.height - 2, 0, 2);
    } else {
        alertController.popoverPresentationController.sourceRect = rect;
    }
    
    [controller presentViewController:alertController animated:animated completion:block];
}

#pragma mark getters

- (NSMutableArray<NSString *> *)normaleTitles {
    if (_normaleTitles == nil) {
        _normaleTitles = [NSMutableArray array];
    }
    return _normaleTitles;
}
- (NSMutableArray<ZRDAlertButtonAction> *)normalActions {
    if (_normalActions == nil) {
        _normalActions = [NSMutableArray array];
    }
    return _normalActions;
}
- (NSMutableArray<NSString *> *)destructiveTitles {
    if (_destructiveTitles == nil) {
        _destructiveTitles = [NSMutableArray array];
    }
    return _destructiveTitles;
}
- (NSMutableArray<ZRDAlertButtonAction> *)destructiveActions {
    if (_destructiveActions == nil) {
        _destructiveActions = [NSMutableArray array];
    }
    return _destructiveActions;
}
- (NSMutableArray<ZRDAlertTextFieldConfiguration> *)textFieldConfigurations {
    if (_textFieldConfigurations == nil) {
        _textFieldConfigurations = [NSMutableArray array];
    }
    return _textFieldConfigurations;
}

@end
