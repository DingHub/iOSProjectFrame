//
//  MyStyle.h
//  iOSProjectFrame
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Ding. All rights reserved.
//

#ifndef MyStyle_h
#define MyStyle_h

/// Base syle defines

// Navigation bar
#define backButtonImageName @"nav_Back"
#define navigationBarTitleColorHexValue 0x474747
#define navigationBarTitleFontSize 15
#define navigationBarTitleTextAttributes @{NSForegroundColorAttributeName: [Color colorWithHex: navigationBarTitleColorHexValue], NSFontAttributeName: [UIFont systemFontOfSize: navigationBarTitleFontSize]}
#define navigationBarBackgroundColorHexValue 0xbbeebb
#define navigationBarBackgroundColor [Color colorWithHex: navigationBarBackgroundColorHexValue]
#define navigationBarShadowImageColor [Color clearColor]

// Color
#define myGreen     [Color colorWithHex: 0x219580]
#define myRed       [Color colorWithHex: 0xf15352]
#define myBlack     [Color colorWithHex: 0x333333]
#define myDarkGray  [Color colorWithHex: 0x999999]
#define myGray      [Color colorWithHex: 0xe1e1e1]
#define myLightGray [Color colorWithHex: 0xf4f4f4]

#endif
