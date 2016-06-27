//
//  HttpHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "HttpHelper.h"
#import "JSONHelper.h"

@implementation HttpHelper

+ (NSString *)host {
#if DEBUG
    return @"http://www.test.com";
#else
    return @"http://www.normal.com";
#endif
}

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
               completion:(void(^)(NSError *error, id responseData))block
{
    NSString *absolutePath = [NSString stringWithFormat:@"%@%@", [self host], path];
    [self requestWithMethod:method path:absolutePath parameters:parameters completion:block];
}

+ (void)requestWithMethod:(RequestMethod)method
                    hoset:(NSString *)host
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *, id))block {
    NSString *absolutePath = [NSString stringWithFormat:@"%@%@", [self host], path];
    [self requestWithMethod:method path:absolutePath parameters:parameters completion:block];
    
}

+ (void)requestWithMethod:(RequestMethod)method
             absolutePath:(NSString *)absolutePath
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *, id))block {
    
    //you can use some vendor such as AFNetworking, ASIHttpRequest, or iOS native API.
    
    //Used Apple's native api here:
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:absolutePath]];
    request.timeoutInterval = 30;
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    switch (method) {
        case POST:
            request.HTTPMethod = @"POST";
            break;
            
        default:
            request.HTTPMethod = @"GET";
            break;
    }
    
    request.HTTPBody = [JSONHelper dataWithJSON:parameters];
    
    NSLog(@"Http request--> %@", request);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            block(error, nil);
            return;
        }
        NSDictionary *dictionary = [JSONHelper JSONWithData:data];
        block(nil, dictionary);
    }];
    [task resume];

}


@end
