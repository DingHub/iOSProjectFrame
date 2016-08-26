//
//  BaseTabelViewController.h
//  iOSProjectFrame
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

const static NSInteger kPageSize = 5;

@interface BaseTabelViewController : BaseViewController

@property (nonatomic, assign) NSInteger pageNumber;

@end
