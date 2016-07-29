//
//  UIAlertController+block.m
//  iOSProjectFrame
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "UIAlertController+block.h"

@implementation UIAlertController (block)

+ (void)showWithStyle:(UIAlertControllerStyle)style
    forViewController:(UIViewController *)viewController
           sourceRect:(CGRect)rect
                title:(NSString *)title
              message:(NSString *)message
destructiveButtonTitle:(NSString *)destructiveTitle
    cancelButtonTitle:(NSString *)cancelTitle
    otherButtonTitles:(NSArray<NSString *> *)otherTitles
  buttonTappedHandler:(AlertButtonTappedBlock)block {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    if (destructiveTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            if (block) {
                block(0);
            }
        }];
        [controller addAction:action];
    }
    
    if (cancelTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (block) {
                block(destructiveTitle ? 1 : 0);
            }
        }];
        [controller addAction:action];
    }
    
    [otherTitles enumerateObjectsUsingBlock:^(NSString * title, NSUInteger i, BOOL * _Nonnull stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (block) {
                NSInteger index = 0;
                if (cancelTitle == nil && destructiveTitle == nil) {
                    index = i;
                } else if (cancelTitle && destructiveTitle){
                    index = i + 2;
                } else {
                    index = i + 1;
                }
                block(index);
            }
        }];
        [controller addAction:action];
    }];
    
    UIPopoverPresentationController *popoverController = controller.popoverPresentationController;
    popoverController.sourceView = viewController.view;
    CGSize size = viewController.view.bounds.size;
    popoverController.sourceRect = CGRectIsNull(rect) ? CGRectMake(size.width/2, size.height - 2, 0, 2) : rect;
    [viewController presentViewController:controller animated:YES completion:nil];
    
}
@end
