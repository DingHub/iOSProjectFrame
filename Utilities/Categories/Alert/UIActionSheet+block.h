//
//  UIActionSheet+block.h
//  iOSProjectFrame
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertHelper.h"

@interface UIActionSheet (block)

/**
 *  @param block    -The index of buttons will ordered like : destructive button -> cancel button -> other buttons
 */
+ (void)showInView:(UIView *)view
             title:(NSString *)title
  destructiveTitle:(NSString *)destructiveTitle
 cancelButtonTitle:(NSString *)cancelTitle
 otherButtonTitles:(NSArray<NSString *> *)otherTitles
buttonTappedHandler:(AlertButtonTappedBlock)block;

@end
