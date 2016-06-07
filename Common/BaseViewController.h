//
//  BaseViewController.h
//  iOSProjectFrame
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark : Here are some headers used frequently

#import "Color.h"



@interface BaseViewController : UIViewController


#pragma mark : Some methods can be overridden

-(void)backButtonPress;



#pragma mark : Some methods used frequently

/**
 *  show aleart to dial a number
 *
 *  @param phoneNumber : the number you want to dial
 */
- (void)dialNumber:(NSString *)phoneNumber;


@end
