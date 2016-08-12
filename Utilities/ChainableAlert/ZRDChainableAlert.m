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

// for UIAlertViewDelegate and UIActionSheetDelegate
static NSMutableArray<ZRDAlertButtonAction> *alertButtonActions;
@interface AlertHelper : NSObject <UIAlertViewDelegate, UIActionSheetDelegate> @end

@implementation AlertHelper

+ (instancetype)sharedHelper {
    static AlertHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[AlertHelper alloc] init];
    });
    return helper;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    alertButtonActions[buttonIndex]();
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    alertButtonActions[buttonIndex]();
}

@end


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
/**
 *  1-normal, 2-destructiv, 3-cancel
 */
@property (nonatomic, assign) int buttonFlag;

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign) BOOL presentAnimated;
@property (nonatomic, assign) CGRect fromRect;

@end

@implementation ZRDChainableAlert

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(enum AlertStyle)style {
    
    self.title = title;
    self.message = message;
    self.style = style;
    
    return self;

}

+ (instancetype)alert:(NSString *)title message:(NSString *)message {
    return [[ZRDChainableAlert alloc] initWithTitle:title message:message style:AlertStyleAlert];
}
+ (instancetype)actionSheet:(NSString *)title message:(NSString *)message {
    return [[ZRDChainableAlert alloc] initWithTitle:title message:message style:AlertStyleActionSheet];
}


- (ZRDAlertButtonTitleReceiver)normalButton {
    [self fillEmptyActions];
    self.buttonFlag = 1;
    return ^ZRDChainableAlert * (NSString *title) {
        [self.normaleTitles addObject:title];
        return self;
    };
}

- (ZRDAlertButtonTitleReceiver)destructiveButton {
    [self fillEmptyActions];
    self.buttonFlag = 2;
    return ^ZRDChainableAlert * (NSString *title) {
        [self.destructiveTitles addObject:title];
        return self;
    };
}


- (ZRDAlertButtonTitleReceiver)cancelButton {
    [self fillEmptyActions];
    self.buttonFlag = 3;
    return ^ZRDChainableAlert * (NSString *title) {
        self.cancelTitle = title;
        return self;
    };
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

- (void)fillEmptyActions {
    switch (self.buttonFlag) {
        case 1:
            if (self.normalActions.count < self.normaleTitles.count) {
                [self.normalActions addObject:^{}];
            }
            break;
        case 2:
            if (self.destructiveActions.count < self.destructiveTitles.count) {
                [self.destructiveActions addObject:^{}];
            }
            break;
        default:
            break;
    }
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
        [self showWithViewController:self.viewController souceRect:self.fromRect animated:self.presentAnimated completion:^{
            if (block) {
                block();
            }
        }];
    };
}

- (void)showWithViewController:(UIViewController *)viewController souceRect:(CGRect)rect animated:(BOOL)animated completion:(void(^)())block {
    if ([[UIDevice currentDevice].systemVersion integerValue] < 8) {
        [self updateAlertButtonActions];
        if (self.style == AlertStyleAlert) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:self.title
                                      message:self.message
                                      delegate:[AlertHelper sharedHelper]
                                      cancelButtonTitle:self.cancelTitle ?: nil
                                      otherButtonTitles:nil];
            for (NSString *title in self.normaleTitles) {
                [alertView addButtonWithTitle:title];
            }
            [alertView show];
        } else {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:self.title
                                          delegate:[AlertHelper sharedHelper]
                                          cancelButtonTitle:self.cancelTitle ?: nil
                                          destructiveButtonTitle:self.destructiveTitles.count ? self.destructiveTitles.firstObject : nil                                                                                                   otherButtonTitles:nil];
            for (NSString *title in self.normaleTitles) {
                [actionSheet addButtonWithTitle:title];
            }
            
            UIViewController *controller = viewController;
            if (controller == nil) {
                controller = [UIApplication sharedApplication].keyWindow.rootViewController;
            }
            [actionSheet showInView:controller.view];
        }
        
    } else {
        UIAlertControllerStyle style = self.style==AlertStyleAlert ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.title message:self.message preferredStyle:style];
        NSInteger i = 0;
        for (NSString *title in self.normaleTitles) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:self.normalActions[i]];
            [alertController addAction:action];
            i ++;
        }
        i = 0;
        for (NSString *title in self.destructiveTitles) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:self.destructiveActions[i]];
            [alertController addAction:action];
            i ++;
        }
        if (self.cancelTitle) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:self.cancelTitle style:UIAlertActionStyleCancel handler:self.cancelAction];
            [alertController addAction:action];
        }
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
}

- (void)updateAlertButtonActions {
    alertButtonActions = [NSMutableArray array];
    if (self.style == AlertStyleActionSheet) {
        if (self.destructiveActions.count > 0) {
            ZRDAlertButtonAction action = self.destructiveActions.firstObject;
            [alertButtonActions addObject:action];
        }
    }
    if (self.cancelAction) {
        [alertButtonActions addObject:self.cancelAction];
    }
    for (ZRDAlertButtonAction action in self.normalActions) {
        [alertButtonActions addObject:action];
    }
}

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


@end
