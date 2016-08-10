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
 *  Heitht of the status bar
 */
+ (CGFloat)statusBarHeight;

@end
