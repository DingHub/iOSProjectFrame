//
//  UIView+Snapshot.m
//  iOSProjectFrame
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)snapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIScrollView (Snapshot)

- (UIImage *)fullSnapshot {
    
    CGRect originFrame = self.frame;
    CGRect frame = originFrame;
    frame.size.height = self.contentSize.height;
    self.frame = frame;
    
    UIImage *image = [self snapshot];
    self.frame = originFrame;
    return image;
}

@end