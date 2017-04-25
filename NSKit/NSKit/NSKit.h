//
//  NSKit.h
//  NSKitDemo
//
//  Created by 相晔谷 on 2016/11/14.
//  Copyright © 2016年 相晔谷. All rights reserved.
//

#ifndef NSKit_h
#define NSKit_h

#import <SDAutoLayout.h>
#import "UIView+YEExtension.h"
#import "UIButton+NSManager.h"
#import "UILabel+NSManager.h"
#import "UITextField+NSManager.h"
#import "UIImageView+NSManager.h"
#import "UIViewController+NSManager.h"

#import "YEAFNRequestManager.h"
#import "YEGCDManager.h"

/***  模型*/
#define __KPropertyString(key)   @property(nonatomic,strong)NSString <Optional>*key;
#define MyDefaults               [NSUserDefaults standardUserDefaults]
#define MyNotification           [NSNotificationCenter defaultCenter]
#define YELog(xx, ...)           NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define YERGBA(r,g,b,a)          [UIColor colorWithRed:(float)r green:(float)g blue:(float)b alpha:a]
#define YERGB(r,g,b)             [UIColor colorWithRed:(float)r green:(float)g blue:(float)b alpha:1]
#define YERandomColor            YNRGBA(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),1)
/** 十六进制颜色*/
#define YEColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//x,y 屏幕适配
#define x(key)                   (float)(key) * SCALE
#define y(key)                   (float)(key) * SCALEWW

#define __kWeak(class)           __weak typeof(class) weakSelf = class;
#define __kStrong(class)         __strong typeof(class) strongSelf = weakSelf;

//字符串是否为空
#define __kIsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isEqualToString:@""]))
//数组是否为空
#define __kIsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

/***  尺寸*/
#define __kNormalFont(key)       [UIFont systemFontOfSize:key]
#define __kFont(key)             [UIFont systemFontOfSize:key*SCALEWW]
#define __kFontAndName(name,key) [UIFont fontWithName:name size:key*SCALEWW]

#define __kScreenWidth           [UIScreen mainScreen].bounds.size.width
#define __kScreenHeight          [UIScreen mainScreen].bounds.size.height
#define __kNavigationViewWidth   64.0f
#define __kTabBarBackViewHeigth  49.0f
#define SCALE                    __kScreenHeight / 667.f
#define SCALEWW                  __kScreenWidth / 375.f

/***  颜色*/
#define __kMainTextColor          [UIColor colorWithRed:0.f/255.f green:0.f/255.f blue:0.f/255.f alpha:1] //1.标题
#define __kWeiHeiTextColor        [UIColor colorWithRed:104.f/255.f green:104.f/255.f blue:104.f/255.f alpha:1] //2.较黑
#define __kWeiWeiHeiTextColor     [UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1] // 微黑
#define __kDetailTextColor        [UIColor colorWithRed:190.f/255.f green:190.f/255.f blue:190.f/255.f alpha:1] //3.正文
#define __kBrownTextColor         [UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:1] //4.黄色
#define __kBrownTransparentColor  [UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:0.75]
#define __kBlueTextColor          [UIColor colorWithRed:0.49f green:0.56f blue:0.67 alpha:1] //5.蓝色
#define __kRedTextColor           [UIColor colorWithRed:252.f/255.f green:91.f/255.f blue:62.f/255.f alpha:1] //6.红色
#define __kRedTransparentColor    [UIColor colorWithRed:252.f/255.f green:91.f/255.f blue:62.f/255.f alpha:0.2] //7.透明度_红色
#define __kGrayBackColor          [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1] //8.底色
#define __kBrownTransparent_Color [UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:0.65] //9.透明度_黄色
#define __kSpaceLineColor         [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1] //10.行间距颜色
#define __KWhiteColor             [UIColor whiteColor] //11.白色

#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >=8.0 ? YES : NO)
#define IOS9 ([[[UIDevice currentDevice] systemVersion] doubleValue] >=9.0 ? YES : NO)
#define IOS10 ([[[UIDevice currentDevice] systemVersion] doubleValue] >=10.0 ? YES : NO)

#endif
