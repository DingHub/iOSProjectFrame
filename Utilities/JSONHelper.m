//
//  JSONHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "JSONHelper.h"
#import "Macros.h"

@implementation JSONHelper


/**
 *  Parse JSON (NSArray, NSDictionary...) to NSData
 *  @param object
 *  @return if failed, nil
 */
+ (NSData *)dataWithJSON:(id)object {
    
    if (object == nil) {
        dLog(@"JSON->NSData failed:JSON is nil");
        return nil;
    }
    NSError *error;
    id data = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    if (error) {
        dLog(@"JSON->NSData failed:%@", error);
        return nil;
    }
    return data;
}
/**
 *  Parse NSData to JSON (NSArray, NSDictionary...)
 *  @param data
 *  @return if failed, nil
 */
+ (id)JSONWithData:(NSData *)data {
    if (data == nil) {
        dLog(@"NSData->JSON failed:data is nil");
        return nil;
    }
    NSError *error;
    id JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        dLog(@"NSData->JSON failed:%@", error);
        return nil;
    }
    return JSON;
}
/**
 *  Parse NSData to mutable JSON (NSMutabelArray, NSNSMutabelDictionary...)
 *  @param data
 *  @return if failed, nil
 */
+ (id)mutableJSONWithData:(NSData *)data {
    return data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] : nil;
}

/**
 *  Parse NSData to NSString
 *  @param data
 *  @return if failed, nil
 */
+ (NSString *)stringWithData:(NSData *)data {
    return data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
}
/**
 *  Parse NSString to NSData
 *  @param string
 *  @return if failed, nil
 */
+ (NSData *)dataWithString:(NSString *)string {
    return string ? [string dataUsingEncoding:NSUTF8StringEncoding] : nil;
}

/**
 *  Parse NSString to JSON (NSArray, NSDictionary...)
 *  @param string
 *  @return if failed, nil
 */
+ (id)JSONWithString:(NSString *)string {
    NSData *data = [self dataWithString:string];
    return [self JSONWithData:data];
}
/**
 *  Parse JSON (NSArray, NSDictionary...) to NSString
 *  @param object
 *  @return if failed, nil
 */
+ (NSString *)stringWithJSON:(id)object {
    NSData *data = [self dataWithJSON:object];
    return [self stringWithData:data];
}


@end
