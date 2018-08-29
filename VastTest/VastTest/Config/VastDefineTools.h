//
//  VastDefineTools.h
//  VastTest
//
//  Created by GoodSrc on 2018/7/24.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#ifndef VastDefineTools_h
#define VastDefineTools_h

//DLog DEBUG模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt,...)NSLog((@"%s[Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#pragma mark ================== 颜色 ========================
#define MyRGB(r,g,b) ([UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1])
#define MyRGBA(r,g,b,a) ([UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a])
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]


//系统版本 宏定义
#define SYSTEM_VERSIONS ([[[UIDevice currentDevice]systemVersion]floatValue])
//屏幕尺寸Rect 宏定义
#define StatusBar_Rect ([[UIApplication sharedApplication] statusBarFrame])
#define SCREEN_RECT ([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT (SCREEN_RECT.size.height)
#define SCREEN_WIDTH  (SCREEN_RECT.size.width)
//屏幕高度，这里减去高度为64的标题栏 宏定义
#define SCREEN_HEIGHT_WithoutBar (SCREEN_RECT.size.height-StatusBar_Rect.size.height-44)
#define kNavBarHeight (StatusBar_Rect.size.height + 44)
#define SCALE [UIScreen mainScreen].bounds.size.width/667//屏幕宽高比

#define Font(x) ([UIFont systemFontOfSize:x])
#define Reverse_Width MAX(SCREEN_HEIGHT, SCREEN_WIDTH)
#define Reverse_Height MIN(SCREEN_WIDTH, SCREEN_HEIGHT)


#endif /* VastDefineTools_h */
