//
//  DeviceHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceHelper : NSObject

/**
 *  The iOS version without the subversion
 *  Example: 7.0
 */
+ (float)iOSVersion;

/**
 *  The device platform string
 *  Example: "iPhone3,2"
 */
+ (NSString *)devicePlatform;
/**
 *  The user-friendly device platform string
 *  Example: "iPad Air (Cellular)"
 */
+ (NSString *)devicePlatformForUser;

/**
 *  Check if the current device is an iPad
 */
+ (BOOL)isiPad;
/**
 *  Check if the current device is an iPhone
 */
+ (BOOL)isiPhone;
/**
 *  Check if the current device is an iPod
 */
+ (BOOL)isiPod;
/**
 *  Check if the current device is the simulator
 */
+ (BOOL)isSimulator;
/**
 *  Check if the current device has a Retina display
 */
+ (BOOL)isRetina;
/**
 *  Check if the current device has a Retina HD display
 */
+ (BOOL)isRetinaHD;

/**
 *  The current device CPU frequency
 */
+ (NSUInteger)cpuFrequency;

/**
 *  The current device BUS frequency
 */
+ (NSUInteger)busFrequency;

/**
 *  The current device RAM size
 */
+ (NSUInteger)ramSize;

/**
 *  The current device CPU number
 */
+ (NSUInteger)cpuNumber;

/**
 *  The current device total memory
 */
+ (NSUInteger)totalMemory;

/**
 *  The current device non-kernel memory
 */
+ (NSUInteger)userMemory;

/**
 *  The current device total disk space
 */
+ (NSNumber *)totalDiskSpace;

/**
 *  The current device free disk space
 */
+ (NSNumber *)freeDiskSpace;

/**
 *  The current device MAC address
 */
+ (NSString *)macAddress;

/**
 *  Generate an unique identifier and store it into standardUserDefaults
 */
+ (NSString *)uniqueIdentifier;

@end
