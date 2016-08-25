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
 */

@interface BaseNavigationController : UINavigationController

/**
 *  Default is to pop view controller animated.
 */
@property (nonatomic, copy) void (^backButtonItemAction)();

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
