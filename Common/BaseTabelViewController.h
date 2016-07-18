//
//  BaseTabelViewController.h
//  iOSProjectFrame
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

const static NSInteger kPageSize = 5;

@interface BaseTabelViewController : UITableViewController

@property (nonatomic, assign) NSInteger pageNumber;
- (void)createRefreshHeaderWithCallback:(void(^)())block;
- (void)createRefreshFooterWithCallback:(void(^)())block;
- (void)noMoreInfoAction;

@end
