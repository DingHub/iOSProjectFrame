//
//  HttpHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHelper : NSObject

/**
 *  GET
 *
 *  @param path       url
 *  @param parameters can be nil
 *  @param block      if failed, block(nil)
 */
+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters completion:(void(^)(id responseData))block;

/**
 *  POST
 *
 *  @param path       url
 *  @param parameters can be nil
 *  @param block      if failed, block(nil)
 */
+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters completion:(void(^)(id responseData))block;

@end
