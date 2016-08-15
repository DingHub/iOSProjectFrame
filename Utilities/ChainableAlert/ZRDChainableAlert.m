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
@property (nonatomic, assign) BOOL textFieldConfiged;

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
    
    self.textFieldConfiged = YES;
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
    return ^ZRDChainableAlert * (NSString *title) {
        [self.normaleTitles addObject:title];
        return self;
    };
}

- (ZRDAlertButtonTitleReceiver)destructiveButton {
    [self fillEmptyButtonAction];
    self.buttonFlag = 2;
    return ^ZRDChainableAlert * (NSString *title) {
        [self.destructiveTitles addObject:title];
        return self;
    };
}


- (ZRDAlertButtonTitleReceiver)cancelButton {
    self.buttonFlag = 3;
    return ^ZRDChainableAlert * (NSString *title) {
        self.cancelTitle = title;
        return self;
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
    return ^ZRDChainableAlert * (ZRDAlertButtonAction action) {
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
        return self;
    };
}


- (ZRDAlertTextFieldReceiver)textField {
    return ^ZRDChainableAlert * () {
        self.textFieldConfiged = NO;
        [self.textFieldConfigurations addObject:^(UITextField *textField){}];
        return self;
    };
}

- (ZRDAlertTextFieldConfigReceiver)configurationHandler {
    return ^ZRDChainableAlert * (ZRDAlertTextFieldConfiguration configuration) {
        NSAssert(self.textFieldConfiged == NO, @"There must have a text field, otherwise, we can't config.");
        self.textFieldConfiged = YES;
        if (configuration) {
            [self.textFieldConfigurations replaceObjectAtIndex:self.textFieldConfigurations.count-1 withObject:configuration];
        }
        return self;
    };
}


- (ZRDAlertShowReceiver)show {
    return ^ZRDChainableAlert * (UIViewController *viewController) {
        self.viewController = viewController;
        return self;
    };
}
- (ZRDAlertAnimationReceiver)animated {
    return ^ZRDChainableAlert * (BOOL animated) {
        self.presentAnimated = animated;
        return self;
    };
}
- (ZRDSourceRectReceiver)sourceRect {
    return ^ZRDChainableAlert * (CGRect rect) {
        self.fromRect = rect;
        return self;
    };
}
- (ZRDCompletionReceriver)completion {
    
    return ^void (ZRDCompletion block)  {
        [self showWithViewController:self.viewController
                           souceRect:self.fromRect
                            animated:self.presentAnimated
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
