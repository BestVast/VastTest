//
//  CustomView.m
//  Initiative
//
//  Created by GoodSrc on 2018/5/16.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import "CustomView.h"
#define DisableColor 0xDEDEDE

@implementation CustomView
+ (UIButton *)getButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor: backGroundColor];
//    [button addTarget:button action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = cornerRadius;
    if (cornerRadius) {
        button.layer.masksToBounds = YES;
    }
    return button;
}
+ (UIButton *)getButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font backGroundColor:(UIColor *)backGroundColor cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = Font(font);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor: backGroundColor];
    button.layer.cornerRadius = cornerRadius;
    if (cornerRadius) {
        button.layer.masksToBounds = YES;
    }
    return button;
}

+ (UILabel *)getLabelFrame:(CGRect)frame text:(NSString *)text font:(NSInteger)font textColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = Font(font);
    label.textColor = textColor;
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
+ (UIImageView *)getDisableBottomLineOriginY:(CGFloat)y {
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, 1)];
    iv.backgroundColor = UIColorFromRGBA(DisableColor, 1.0);
    return iv;
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
