//
//  ImageHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "ImageHelper.h"

@implementation ImageHelper

+ (UIImage *)imageFromColor:(UIColor *)color {
    return [self imageFromColor:color andSize:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)imageFromColor:(UIColor *)color andSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)imageWithSourceImage:(UIImage *)sourceImage compressedToWidth:(CGFloat)newWidth {
    CGFloat origonWidth = sourceImage.size.width;
    CGFloat origonHeight = sourceImage.size.height;
    CGFloat newHeight = origonHeight * newWidth / origonWidth;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    return [self imageWithSourceImage:sourceImage compressedToSize:newSize];
}

+(UIImage *)imageWithSourceImage:(UIImage *)sourceImage compressedToSize:(CGSize)newSize {
    NSLog(@"origon image size : %@",NSStringFromCGSize(sourceImage.size));
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"new image size : %@",NSStringFromCGSize(newImage.size));
    return newImage;
}


@end
