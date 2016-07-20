//
//  UIAlertView+block.h
//  iOSProjectFrame
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertHelper.h"

@interface UIAlertView (block)

/**
 *  @param block    -The index of buttons will ordered like : cancel button -> other buttons
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelTitle
    otherButtonTitles:(NSArray<NSString *> *)otherTitles
  buttonTappedHandler:(AlertButtonTappedBlock)block;

@end
