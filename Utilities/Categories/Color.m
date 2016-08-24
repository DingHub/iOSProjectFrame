//
//  Color.m
//  iOSProjectFrame
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 Ding. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Color.h"

@implementation Color (HexColorAddition)

+ (Color *)colorWithHex:(UInt32)hex {
    return [self colorWithHex: hex alpha: 1];
}

+ (Color *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    UInt32 mask = 0x000000FF;
    CGFloat red = ((hex >> 16) & mask) / 255.0;
    CGFloat green = ((hex >> 8) & mask) / 255.0;
    CGFloat blue = (hex & mask) / 255.0;
    return [Color colorWithRed: red green: green blue: blue alpha:alpha];
}

+ (Color *)colorWithHexString:(NSString *)hexString {
    return [[self class] colorWithHexString:hexString alpha:1.0];
}

+ (Color *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    if (hexString.length == 0) {
        return nil;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([hexString hasPrefix:@"#"]) {
        scanner.scanLocation = 1;
    }
    
    UInt32 color = 0;
    
    if ([scanner scanHexInt:&color]) {
        return [self colorWithHex:color alpha: alpha];
    } else {
        return [self colorWithHex:0x000000 alpha:alpha];
    }
}


@end
