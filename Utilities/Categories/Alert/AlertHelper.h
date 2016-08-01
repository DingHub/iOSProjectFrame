//
//  AlertHelper.h
//  iOSProjectFrame
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertButtonTappedBlock)(NSInteger buttonIndex);

@interface AlertHelper : NSObject <UIAlertViewDelegate, UIActionSheetDelegate>

+ (instancetype)sharedHelper;

+ (void)setButtonTappedHandler:(AlertButtonTappedBlock)handler;

@end
