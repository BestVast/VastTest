//
//  VastMagnifierTool.h
//  VastTest
//
//  Created by GoodSrc on 2018/10/25.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MagnifierStyle) {
    // 圆形放大镜
    MagnifierStyle_Circle = 0,
    // 方形放大镜
    MagnifierStyle_Square,
};

typedef NS_ENUM(NSInteger, MagnifierDirection) {
    // 左上
    MagnifierDirection_LeftTop = 0,
    // 上
    MagnifierDirection_Top,
    // 右上
    MagnifierDirection_RightTop,
    // 右
    MagnifierDirection_Right,
    // 右下
    MagnifierDirection_RightBottom,
    // 下
    MagnifierDirection_Bottom,
    // 左下
    MagnifierDirection_LeftBottom,
    // 左
    MagnifierDirection_Left,
    // 中间
    MagnifierDirection_Center,
};
NS_ASSUME_NONNULL_BEGIN
/**
 * 放大镜管理类 (借鉴: https://juejin.im/post/5a701899f265da3e283a4c19)
*/
@interface VastMagnifierTool : NSObject
// 放大镜 宽度，默认90
@property (nonatomic, assign)   float magnifierWidth;
// 放大镜 倍数，默认1.5
@property (nonatomic, assign)   float magnifyMultiple;
// 放大镜 形状，默认圆形
@property (nonatomic, assign)   MagnifierStyle magnStyle;
// 放大镜 背景图
@property (nonatomic, strong)   UIImage *magnBackImg;
// 触点 相对于 放大镜的位置, 默认中间
@property (nonatomic, assign)   MagnifierDirection magnShowDirection;
// 触点作为 放大镜截图的位置, 默认中间
@property (nonatomic, assign)   MagnifierDirection imageCutLocation;
+ (instancetype)sharedInstance;
- (void)magnifier_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)magnifier_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)magnifier_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_END
