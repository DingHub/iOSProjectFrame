//
//  DeviceHelper.m
//  iOSProjectFrame
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import "DeviceHelper.h"
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>

static NSString * const UniqueIdentifierDefaultsKey = @"UniqueIdentifier";
static NSDictionary *platformMap;
@implementation DeviceHelper

+ (NSString *)systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    return platform;
}
+ (NSString *)platformForUser {
    NSString *platform = [self platform];
    if (platformMap == nil) {
        platformMap = @{
                        //  iPhone
                        @"iPhone1,1": @"iPhone 2G",
                        @"iPhone1,2": @"iPhone 3G",
                        @"iPhone2,1": @"iPhone 3GS",
                        @"iPhone3,1": @"iPhone 4",
                        @"iPhone3,3": @"iPhone 4 (CDMA)",
                        @"iPhone4,1": @"iPhone 4S",
                        @"iPhone5,1": @"iPhone 5 (GSM)",
                        @"iPhone5,2": @"iPhone 5 (CDMA)",
                        @"iPhone5,3": @"iPhone 5C (GSM)",
                        @"iPhone5,4": @"iPhone 5C (Global)",
                        @"iPhone6,1": @"iPhone 5S (GSM)",
                        @"iPhone6,2": @"iPhone 5S (Global)",
                        @"iPhone7,1": @"iPhone 6 Plus",
                        @"iPhone7,2": @"iPhone 6",
                        @"iPhone8,1": @"iPhone 6s",
                        @"iPhone8,2": @"iPhone 6s Plus",
                        //  iPod
                        @"iPod1,1": @"iPod Touch 1G",
                        @"iPod2,1": @"iPod Touch 2G",
                        @"iPod3,1": @"iPod Touch 3G",
                        @"iPod4,1": @"iPod Touch 4G",
                        @"iPod5,1": @"iPod Touch 5G",
                        //  iPad
                        @"iPad1,1": @"iPad 1",
                        @"iPad2,1": @"iPad 2 (WiFi)",
                        @"iPad2,2": @"iPad 2 (GSM)",
                        @"iPad2,3": @"iPad 2 (CDMA)",
                        @"iPad2,4": @"iPad 2 (32nm)",
                        @"iPad2,5": @"iPad mini (WiFi)",
                        @"iPad2,6": @"iPad mini (GSM)",
                        @"iPad2,7": @"iPad mini (CDMA)",
                        @"iPad3,1": @"iPad 3 (WiFi)",
                        @"iPad3,2": @"iPad 3 (CDMA)",
                        @"iPad3,3": @"iPad 3 (GSM)",
                        @"iPad3,4": @"iPad 4 (WiFi)",
                        @"iPad3,5": @"iPad 4 (GSM)",
                        @"iPad3,6": @"iPad 4 (CDMA)",
                        @"iPad4,1": @"iPad Air (WiFi)",
                        @"iPad4,2": @"iPad Air (Cellular)",
                        @"iPad4,3": @"iPad Air (China)",
                        @"iPad4,4": @"iPad mini 2 (WiFi)",
                        @"iPad4,5": @"iPad mini 2 (Cellular)",
                        @"iPad4,6": @"iPad mini 2 (China)",
                        @"iPad4,7": @"iPad mini 3 (WiFi)",
                        @"iPad4,8": @"iPad mini 3 (Cellular)",
                        @"iPad4,9": @"iPad mini 3 (China)",
                        @"iPad5,3": @"iPad Air 2 (WiFi)",
                        @"iPad5,4": @"iPad Air 2 (Cellular)",
                        //  simulator
                        @"i386": @"Simulator (iPhone)",
                        @"x86_64": @"Simulator (iPad)"
                        };
    }
    return platformMap[platform] ?: platform;
}

+ (BOOL)isiPad {
    return [[[self platform] substringToIndex:4] isEqualToString:@"iPad"];
}
+ (BOOL)isiPhone {
    return [[[self platform] substringToIndex:6] isEqualToString:@"iPhone"];
}
+ (BOOL)isiPod {
    return  [[[self platform] substringToIndex:4] isEqualToString:@"iPod"];
}
+ (BOOL)isSimulator {
    return [[self platform] isEqualToString:@"i386"]
    || [[self platform] isEqualToString:@"x86_64"];
}
+ (BOOL)isRetina {
    UIScreen *screen = [UIScreen mainScreen];
    return [screen respondsToSelector:@selector(displayLinkWithTarget:selector:)] && screen.scale >= 2.0;
}
+ (BOOL)isRetinaHD {
    UIScreen *screen = [UIScreen mainScreen];
    return [screen respondsToSelector:@selector(displayLinkWithTarget:selector:)] && screen.scale >= 3.0;
}

+ (NSUInteger)cpuFrequency {
    return [self p_getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)busFrequency {
    return [self p_getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ramSize {
    return [self p_getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)cpuNumber {
    return [self p_getSysInfo:HW_NCPU];
}


+ (NSUInteger)totalMemory {
    return [self p_getSysInfo:HW_PHYSMEM];
}


+ (NSUInteger)userMemory {
    return [self p_getSysInfo:HW_USERMEM];
}

+ (NSUInteger)totalDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemSize] integerValue];
}

+ (NSUInteger)freeDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemFreeSize] integerValue];
}

+ (NSString *)macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)uniqueIdentifier {
    NSString *uuid;
    if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        uuid = [defaults objectForKey:UniqueIdentifierDefaultsKey];
        if (!uuid) {
            uuid = [self p_generateUUID];
            [defaults setObject:uuid forKey:UniqueIdentifierDefaultsKey];
            [defaults synchronize];
        }
    }
    return uuid;

}

#pragma mark - Private
+ (NSUInteger)p_getSysInfo:(uint)typeSpecifier {    
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

+ (NSString *)p_generateUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}
@end
