//
//  ImageHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageHelper : NSObject

+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color andSize:(CGSize)size;

+ (UIImage *)imageWithSourceImage:(UIImage *)sourceImage compressedToWidth:(CGFloat)newWidth;
+ (UIImage *)imageWithSourceImage:(UIImage *)sourceImage compressedToSize:(CGSize)newSize;

@end
