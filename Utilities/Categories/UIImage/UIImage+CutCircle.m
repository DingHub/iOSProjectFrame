//
//  UIImage+CutCircle.m
//  iOSProjectFrame
//
//  Created by admin on 16/8/24.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "UIImage+CutCircle.h"

@implementation UIImage (CutCircle)

- (UIImage *)circleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
