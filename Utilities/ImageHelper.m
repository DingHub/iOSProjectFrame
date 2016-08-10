//
//  ImageHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "ImageHelper.h"
#import "UIView+Snapshot.h"

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


+ (UIImage *)imageFromSourceImage:(UIImage *)sourceImage compressedToWidth:(CGFloat)newWidth {
    CGFloat origonWidth = sourceImage.size.width;
    CGFloat origonHeight = sourceImage.size.height;
    CGFloat newHeight = origonHeight * newWidth / origonWidth;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    return [self imageFromSourceImage:sourceImage compressedToSize:newSize];
}

+(UIImage *)imageFromSourceImage:(UIImage *)sourceImage compressedToSize:(CGSize)newSize {
    if (sourceImage == nil) {
        return nil;
    }
    NSLog(@"origon image size : %@",NSStringFromCGSize(sourceImage.size));
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"new image size : %@",NSStringFromCGSize(newImage.size));
    return newImage;
}

+ (UIImage *)imageFromSourceImage:(UIImage *)sourceImage frame:(CGRect)frame {
    CGImageRef imageRef = CGImageCreateWithImageInRect(sourceImage.CGImage, frame);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

+ (UIImage *)screenShot {
    return [UIApplication sharedApplication].keyWindow.snapshot;
}

@end
