//
//  FileHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

/**
 *  Path of file in the main bundle
 */
+ (NSString *)bundlePathFor:(NSString *)fileName;
/**
 *  Path of file in the sand box // document
 */
+ (NSString *)documentPathFor:(NSString *)fileName;
/**
 *  Document path in the sand box
 */
+ (NSString *)documentPath;

+ (NSString *)appGroupDocumentPathWithId:(NSString *)appGroupId;

@end
