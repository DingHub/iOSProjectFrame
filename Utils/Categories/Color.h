//
//  Color.h
//  iOSProjectFrame
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 Ding. All rights reserved.
//

#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
    #import <UIKit/UIKit.h>
    #define Color UIColor
#else
    #import <Foundation/Foundation.h>
    #define Color NSColor
#endif

@interface Color (HexColorAddition)

+ (Color *)randomColor;

+ (Color *)colorWithHexString:(NSString *)hexString;
+ (Color *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (Color *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (Color *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

@end
