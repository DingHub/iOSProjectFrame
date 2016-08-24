//
//  Color.h
//  iOSProjectFrame
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 Ding. All rights reserved.
//

#define Color UIColor

@interface Color (HexColorAddition)

/**
 *  Creates a color of random red, green and blue
 *  @return random color
 */
+ (Color *)randomColor;

/**
 *  Creates a color from an hex integer (e.g. 0x3498db). alpha will be 1.
 *  @param hex A hexa-decimal UInt32 that represents a color.
 */
+ (Color *)colorWithHex:(UInt32)hex;
/**
 *  Creates a color from an hex integer (e.g. 0x3498db).
 *  @param hex   A hexa-decimal UInt32 that represents a color.
 *  @param alpha alpha
 */
+ (Color *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

/**
 *  Creates a color from an hex string (e.g. "3498db" or "#3498db").
 *  If the given hex string is invalid the initialiser will create a black color.
 *  @param hexString A hexa-decimal color string representation.
 */
+ (Color *)colorWithHexString:(NSString *)hexString;
/**
 *  Creates a color from an hex string (e.g. "3498db" or "#3498db").alpha will be 1.
 *  If the given hex string is invalid the initialiser will create a black color.
 *  @param hexString A hexa-decimal color string representation.
 *  @param alpha     alpha
 */
+ (Color *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


@end
