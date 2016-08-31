//
//  HttpHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 HTTP method definitions.
 */
typedef NS_ENUM(NSInteger, HttpRequestMethod) {
    GET = 0,
    POST
};

@interface HttpHelper : NSObject

/**
 *  Http request
 *  @param method     GET, POST and so on
 *  @param path       can be connected with parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"; The real path will be [host]+path
 *  @param parameters can be nil
 *  @param block      if failed, responseData will be nil and an error be generated.
 */
+ (void)requestWithMethod:(HttpRequestMethod)method
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
               completion:(void(^)(NSError *error, id responseData))block;

/**
 *  Http request
 *  @param method     GET, POST and so on
 *  @param path       can be connected with parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"; The real path will be [host]+path
 *  @param parameters can be nil
 *  @param timeout    set timeout with this parameter, unit is second
 *  @param block      if failed, responseData will be nil and an error be generated.
 */
+ (void)requestWithMethod:(HttpRequestMethod)method
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
                  timeout:(NSTimeInterval)timeout
               completion:(void(^)(NSError *error, id responseData))block;

/**
 *  Http request
 *  @param method     GET, POST and so on
 *  @param host       e.g. "https://www.test.com"
 *  @param path       can be connected with parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"
 *  @param parameters can be nil
 *  @param block      if failed, responseData will be nil and an error be generated.
 */
+ (void)requestWithMethod:(HttpRequestMethod)method
                     host:(NSString *)host
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *error, id responseData))block;

/**
 *  Http request
 *  @param method       GET, POST and so on
 *  @param absolutePath e.g. "https://www.test.com/mobileserver/searchKey.Do?key=hell0"
 *  @param parameters   can be nil
 *  @param block        if failed, responseData will be nil and an error be generated.
 */
+ (void)requestWithMethod:(HttpRequestMethod)method
             absolutePath:(NSString *)absolutePath
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *error, id responseData))block;

@end
