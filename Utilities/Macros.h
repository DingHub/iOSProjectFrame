//
//  Macros.h
//  iOSProjectFrame
//
//  Created by admin on 16/6/2.
//  Copyright © 2016年 Ding. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#ifndef __OPTIMIZE__

/** Log */
// print when debuging
#define log(format, ...) NSLog(format, ## __VA_ARGS__)
// print detail log (starts with file name, line number and method name) when debuging
# define dLog(format, ...) NSLog((@"⭐️%@🔸%d🌜%s🌛\n" format), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __FUNCTION__, ##__VA_ARGS__)

#else

/** Log */
#define NSLog(...)
#define dLog(object, ...)
#define log(object, ...)

#endif /* __OPTIMIZE__ */

/** weak-strong dance */

/**
 *  e.g.
 
 ①
 DanceWeak(self);
 
 ②
 ... ^(...) {
    weak_self.title = @"Hello";
 };
 
 or
 ... ^(...) {
    ③
    DanceStrong(self);
    ...
    self.title = @"Hello";
 };
 
 */
#define DanceWeak(obj) __weak typeof(obj) weak_##obj = obj
#define DanceStrong(obj) __strong typeof(obj) obj = weak_##obj


#endif /* Macros_h */
