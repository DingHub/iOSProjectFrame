//
//  GCD.m
//  iOSProjectFrame
//
//  Created by admin on 2016/10/14.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "GCD.h"

@implementation GCD

+ (void)runAfter:(NSTimeInterval)seconds action:(Action)block {
    [GCD runAfter:seconds queue:dispatch_get_main_queue() action:block];
}
+ (void)runAfter:(NSTimeInterval)seconds queue:(dispatch_queue_t)queue action:(Action)block {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(time, queue, ^(void){
        if (block) {
            block();
        }
    });
}

@end
