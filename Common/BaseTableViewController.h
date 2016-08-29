//
//  BaseTableViewController.h
//  iOSProjectFrame
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

static const NSInteger pageSize = 5;

@interface BaseTableViewController : BaseViewController

@property (nonatomic, assign) NSInteger pageNumber;

@end
