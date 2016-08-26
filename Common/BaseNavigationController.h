//
//  BaseNavigationController.h
//  iOSProjectFrame
//
//  Created by admin on 16/8/25.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  A UINavigationController subclass allowing the interactive pop gesture to be recognized when the navigation bar is hidden or a custom back button is used.
 *  We can also custom appearance of the navigation bar in the impletion file(BaseNavigationController.m).
 *
 *  Thanks for https://github.com/fastred/AHKNavigationController
 */

@interface BaseNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
