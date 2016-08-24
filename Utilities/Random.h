//
//  Random.h
//  iOSProjectFrame
//
//  Created by admin on 16/8/24.
//  Copyright © 2016年 Ding. All rights reserved.
//

@import UIKit;
#import "Color.h"

@interface Random : NSObject

/**
 *  @return lower <= value <= upper
 */
+ (NSInteger)intWithLower:(NSInteger)lower upper:(NSInteger)upper;

/**
 *  @return true or false, randomly~
 */
+ (BOOL)boolean;

/**
 *  @return lower <= value <= upper
 */
+ (double)doubleWithLower:(double)lower upper:(double)upper;

/**
 *  @return lower <= value <= upper
 */
+ (float)floatWithLower:(float)lower upper:(float)upper;

/**
 *  @return lower <= value <= upper
 */
+ (CGFloat)CGFloatWithLower:(CGFloat)lower upper:(CGFloat)upper;

/**
 *  @return A color of random red, green and blue, alpha is 1.
 */
+ (Color *)color;

/**
 *  @return a random item in array
 */
+ (id)itemOfArray:(NSArray *)array;

@end
