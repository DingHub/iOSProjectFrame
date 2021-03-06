//
//  Screen.h
//  iOSProjectFrame
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Screen : NSObject

/**
 *  Bounds of the main screen
 */
+ (CGRect)bounds;

/**
 *  Size of the main screen
 */
+ (CGSize)size;

/**
 *  Width of the main screen
 */
+ (CGFloat)width;

/**
 *  Height of the main screen
 */
+ (CGFloat)height;

/**
 *  Height of the status bar
 */
+ (CGFloat)statusBarHeight;

@end
