//
//  HttpHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "HttpHelper.h"
#import "JSONHelper.h"
#import "Macros.h"

static const NSTimeInterval kTimeout = 30;
@implementation HttpHelper

+ (NSString *)host {
#if DEBUG
    return @"https://www.test.com";
#else
    return @"https://www.normal.com";
#endif
}

+ (void)requestWithMethod:(HttpRequestMethod)method
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
               completion:(void(^)(NSError *error, id responseData))block {
    
    NSString *absolutePath = [NSString stringWithFormat:@"%@%@", [self host], path];
    [self requestWithMethod:method absolutePath:absolutePath parameters:parameters completion:block];
}

+ (void)requestWithMethod:(HttpRequestMethod)method
                    host:(NSString *)host
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *error, id responseData))block {
    
    NSString *absolutePath = [NSString stringWithFormat:@"%@%@", [self host], path];
    [self requestWithMethod:method absolutePath:absolutePath parameters:parameters completion:block];
    
}

+ (void)requestWithMethod:(HttpRequestMethod)method
             absolutePath:(NSString *)absolutePath
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *error, id responseData))block {
    [self requestWithMethod:method absolutePath:absolutePath parameters:parameters timeout:kTimeout completion:block];
}

+ (void)requestWithMethod:(HttpRequestMethod)method
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
                  timeout:(NSTimeInterval)timeout
               completion:(void(^)(NSError *error, id responseData))block {
    NSString *absolutePath = [NSString stringWithFormat:@"%@%@", [self host], path];
    [self requestWithMethod:method absolutePath:absolutePath parameters:parameters timeout:timeout completion:block];
}

+ (void)requestWithMethod:(HttpRequestMethod)method
             absolutePath:(NSString *)absolutePath
               parameters:(NSDictionary *)parameters
                  timeout:(NSTimeInterval)timeout
               completion:(void (^)(NSError *error, id responseData))block {
    //you can use some vendor such as AFNetworking, ASIHttpRequest, or iOS native API.
    
    //Used Apple's native api here:
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:absolutePath]];
    request.timeoutInterval = timeout;
    
    switch (method) {
        case POST:
            request.HTTPMethod = @"POST";
            break;
            
        default:
            request.HTTPMethod = @"GET";
            break;
    }
    
    if (parameters) {
        request.HTTPBody = [JSONHelper dataWithJSON:parameters];
    }
    
    dLog(@"%@", [self combinedStringWithURL:absolutePath parameters:parameters]);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                block(error, nil);
                return;
            }
            NSDictionary *dictionary = [JSONHelper JSONWithData:data];
            block(nil, dictionary);
        });
    }];
    [task resume];
}

/**
 *  Combine URL and parameters as a String
 *  @param URLString  e.g. "https://www.test.com"
 *  @param parameters e.g. ["key": "value"]
 *  @return e.g. "https://www.test.com?key=value"
 */
+ (NSString *)combinedStringWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters {
    NSString *parString = [JSONHelper stringWithJSON:parameters];
    if (URLString == nil || parString == nil) {
        return URLString;
    }
    NSMutableString *result = [NSMutableString stringWithString:URLString];
    [result appendString:@"?"];
    
    if ([parString hasPrefix:@"{"]) {
        parString = [parString substringFromIndex:1];
    }
    if ([parString hasSuffix:@"}"]) {
        parString = [parString substringToIndex:parString.length-1];
    }
    parString = [parString stringByReplacingOccurrencesOfString:@":" withString:@"="];
    parString = [parString stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    parString = [parString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    [result appendString:parString];
    return result;
}


@end
