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
typedef NS_ENUM(NSInteger, RequestMethod) {
    GET = 0,
    POST
};

@interface HttpHelper : NSObject

/**
 *  Http request
 *  @param method     GET, POST and so on
 *  @param path       can be connected with parameters, e.g. "/mobileserver/searchKey.Do?key=hell0"
 *  @param parameters can be nil
 *  @param block      if failed, error will be a hint message and data will be nil
 */
+ (void)requestWithMethod:(RequestMethod)method
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
               completion:(void(^)(NSError *error, id responseData))block;

@end
