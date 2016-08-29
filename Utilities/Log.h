//
//  Log.h
//  iOSProjectFrame
//
//  Created by admin on 16/6/2.
//  Copyright © 2016年 Ding. All rights reserved.
//

#ifndef Log_h
#define Log_h

#ifndef __OPTIMIZE__

/**
 print when debuging
 */
#define log(format, ...) NSLog(format, ## __VA_ARGS__)

/**
 print detail log (starts with file name, line number and method name) when debuging
 */
# define dLog(format, ...) NSLog((@"⭐️%@🔸%d🌜%s🌛\n" format), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __FUNCTION__, ##__VA_ARGS__)

#else

#define NSLog(...)
#define dLog(object, ...)
#define log(object, ...)

#endif /* __OPTIMIZE__ */


#endif /* JustForLog_pch */