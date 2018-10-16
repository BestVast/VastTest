//
//  CustomView.h
//  Initiative
//
//  Created by GoodSrc on 2018/5/16.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomView : NSObject

//获取button
+ (UIButton *)getButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor cornerRadius:(CGFloat)cornerRadius;

//获取button
+ (UIButton *)getButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font backGroundColor:(UIColor *)backGroundColor cornerRadius:(CGFloat)cornerRadius;

//获取label
+ (UILabel *)getLabelFrame:(CGRect)frame text:(NSString *)text font:(NSInteger)font textColor:(UIColor *)textColor;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

//获取一个颜色为f3f3f3，1px的label
+ (UIImageView *)getDisableBottomLineOriginY:(CGFloat)y;
@end
