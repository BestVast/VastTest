//
//  VastAlertView.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/6.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface VastAlertAction : NSObject
@property (nonatomic, copy)     NSString *title;
@property (nonatomic, assign)   NSInteger index;
@property (nonatomic, assign)   UIAlertActionStyle style;
- (instancetype)initWithTitle:(NSString *)title index:(NSInteger)index style:(UIAlertActionStyle)style;
@end

@interface VastAlertView : NSObject


/**
 AlertViewController弹框

 @param title alert标题
 @param message alert描述信息
 @param style alert style
 @param actions alert 按钮数组
 @param callback 点击alert按钮回调
 */
+ (void)presentVastAlertVcTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)style actions:(NSArray<VastAlertAction *> *)actions callback:(void (^ __nullable)(VastAlertAction *action))callback;

@end
NS_ASSUME_NONNULL_END
