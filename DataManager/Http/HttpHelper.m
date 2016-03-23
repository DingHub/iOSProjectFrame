//
//  HttpHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "HttpHelper.h"

typedef NS_ENUM(NSInteger, RequestMethod) {
    GET = 0,
    POST,
    PUT,
    DELETE
};

@implementation HttpHelper

+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters completion:(void(^)(id responseData))block {
    [self httpRequestWithMethod:GET path:path parameters:parameters completion:block];
}

+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters completion:(void(^)(id responseData))block {
    [self httpRequestWithMethod:POST path:path parameters:parameters completion:block];
}

+ (void)httpRequestWithMethod:(RequestMethod)method path:(NSString *)path parameters:(NSDictionary *)parameters completion:(void(^)(id responseData))block {
    NSLog(@"HTTP reauest:%@\nparameters:%@", path, parameters);
    //you can use some vendor such as AFNetworking, ASIHttpRequet, or iOS native API.
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    switch (method) {
        case GET: {
//            [manager GET:path parameters:path success:^(AFHTTPRequestOperation *operation, id data) {
//                block(data);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                block(nil);
//                [self showError:error];
//            }];
            break;
        }
        case POST: {
//            [manager POST:path parameters:path success:^(AFHTTPRequestOperation *operation, id data) {
//                block(data);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                block(nil);
//                [self showError:error];
//            }];
            break;
        }
        default:
            break;
    }
}

+ (void)showError:(NSError *)error {
    NSLog(@"network request error：%@",error.description);
    //[SVProgressHUD dismiss];
}


@end
