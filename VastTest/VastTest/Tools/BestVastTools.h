//
//  BestHaoTools.h
//  KingDraw
//
//  Created by GoodSrc on 2018/7/18.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BestVastTools : NSObject

#pragma mark ==printf打印==
+ (void)printObj:(NSString *)obj;
#pragma mark ==数字字符串转十六进制数==
+ (unsigned long)getColorHexBy:(NSString *)string;

#pragma mark ==trim截取字符串头尾的空格和换行符==
+ (NSString *)trimStringWhitespaceAndNewlineCharBy:(NSString *)string;

#pragma mark ==正则截取匹配的字符串(数字), 返回 [(数字), (数字), ...] 数组==
+ (NSArray *)regularSearchBracketAndNumString:(NSString *)search;

#pragma mark ==打印所有文件名, 数据库中存储的文件名==
+ (void)logFileName;

#pragma mark ==string width==
+ (CGFloat)widthGetByTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
