//
//  ImageHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageHelper : NSObject

/**
 *  generate image with color
 *  @return the image size will be (1.0, 1.0)
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 *  generate image with color and size
 */
+ (UIImage *)imageFromColor:(UIColor *)color andSize:(CGSize)size;

/**
 *  Compress image
 */
+ (UIImage *)imageFromSourceImage:(UIImage *)sourceImage compressedToWidth:(CGFloat)newWidth;
/**
 *  Compress image
 */
+ (UIImage *)imageFromSourceImage:(UIImage *)sourceImage compressedToSize:(CGSize)newSize;

/**
 *  Cut image with frame
 */
+ (UIImage *)imageFromSourceImage:(UIImage *)sourceImage frame:(CGRect)frame;

/**
 *  return whole screen shot
 */
+ (UIImage *)screenShot;

@end
