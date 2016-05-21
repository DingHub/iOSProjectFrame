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
               completion:(void(^)(NSString *error, id responseData))block
{
    NSString *url = [NSString stringWithFormat:@"%@%@", [self host], path];
    //you can use some vendor such as AFNetworking, ASIHttpRequet, or iOS native API.
    
    //  1.  Used Apple's native api here
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
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
    
    NSLog(@"%@", request);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.description);
            NSString *hint = [NSString stringWithFormat:@"error, code is %zd", error.code];
            block(hint, nil);
            return;
        }
        NSDictionary *dictionary = [JSONHelper JSONWithData:data];
        block(nil, dictionary);
    }];
    [task resume];
    

    //  2.  Here is an implement example of AFNetworking
    
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //    switch (method) {
    //        case GET: {
    //            [manager GET:url parameters:parameterssuccess:^(AFHTTPRequestOperation *operation, id data) {
    //                block(data);
    //            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //                NSString *errorStr = error.description;
    //                block(errorStr, nil);
    //            }];
    //            break;
    //        }
    //        case POST: {
    //            [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id data) {
    //                block(data);
    //            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //                NSString *errorStr = error.description;
    //                block(errorStr, nil);
    //            }];
    //            break;
    //        }
    //        default:
    //            break;
    //    }

    
}


@end
