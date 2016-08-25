//
//  Random.m
//  iOSProjectFrame
//
//  Created by admin on 16/8/24.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "Random.h"

@implementation Random

+ (NSInteger)intWithLower:(NSInteger)lower upper:(NSInteger)upper {
    return lower + (NSInteger)arc4random_uniform((u_int32_t)(upper - lower + 1));
}

+ (BOOL)boolean {
    return arc4random_uniform(2) == 1;
}

+ (double)doubleWithLower:(double)lower upper:(double)upper {
    return ((double)arc4random() / UINT32_MAX) * (upper - lower) + lower;
}

+ (float)floatWithLower:(float)lower upper:(float)upper {
    return ((float)(arc4random()) / UINT32_MAX) * (upper - lower) + lower;
}

+ (CGFloat)CGFloatWithLower:(CGFloat)lower upper:(CGFloat)upper {
    return (CGFloat)((CGFloat)arc4random() / UINT32_MAX) * (upper - lower) + lower;
}

+ (Color *)color {
    return [Color colorWithRed:[self CGFloatWithLower:0 upper:1]
                         green:[self CGFloatWithLower:0 upper:1]
                          blue:[self CGFloatWithLower:0 upper:1]
                         alpha:1];
}

+ (id)itemOfArray:(NSArray *)array {
    NSInteger index = (NSInteger)arc4random_uniform((u_int32_t)array.count);
    return array[index];
}

@end
