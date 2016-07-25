//
//  JSONHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

/**
 *  Parse JSON (NSArray, NSDictionary...) to NSData
 *  @param object
 *  @return if failed, nil
 */
+ (NSData *)dataWithJSON:(id)object;
/**
 *  Parse NSData to JSON (NSArray, NSDictionary...)
 *  @param data
 *  @return if failed, nil
 */
+ (id)JSONWithData:(NSData *)data;
/**
 *  Parse NSData to mutable JSON (NSMutabelArray, NSNSMutabelDictionary...)
 *  @param data
 *  @return if failed, nil
 */
+ (id)mutableJSONWithData:(NSData *)data;

/**
 *  Parse NSData to NSString
 *  @param data
 *  @return if failed, nil
 */
+ (NSString *)stringWithData:(NSData *)data;
/**
 *  Parse NSString to NSData
 *  @param string
 *  @return if failed, nil
 */
+ (NSData *)dataWithString:(NSString *)string;

/**
 *  Parse NSString to JSON (NSArray, NSDictionary...)
 *  @param string
 *  @return if failed, nil
 */
+ (id)JSONWithString:(NSString *)string;
/**
 *  Parse JSON (NSArray, NSDictionary...) to NSString
 *  @param object
 *  @return if failed, nil
 */
+ (NSString *)stringWithJSON:(id)object;

@end
