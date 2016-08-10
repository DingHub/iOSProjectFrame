//
//  FileHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "FileHelper.h"

@implementation FileHelper

+ (NSString *)bundlePathFor:(NSString *)fileName {
    return [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:fileName];
}

+ (NSString *)documentPathFor:(NSString *)fileName {
    return [self.documentPath stringByAppendingPathComponent:fileName];
}

+ (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)appGroupDocumentPathWithId:(NSString *)appGroupId {
    NSURL *url = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGroupId];
    NSString *path = [url absoluteString];
    path = [path stringByReplacingOccurrencesOfString:@"file" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, path.length)];
    return path;
}

@end
