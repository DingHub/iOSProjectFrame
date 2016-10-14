//
//  GCD.h
//  iOSProjectFrame
//
//  Created by admin on 2016/10/14.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCD : NSObject
typedef void(^Action)();

+ (void)runAfter:(NSTimeInterval)seconds action:(Action)block;
+ (void)runAfter:(NSTimeInterval)seconds queue:(dispatch_queue_t)queue action:(Action)block;


@end
