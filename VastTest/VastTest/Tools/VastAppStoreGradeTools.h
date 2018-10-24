//
//  VastAppStoreGradeTools.h
//  KingDraw
//
//  Created by GoodSrc on 2018/10/24.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define KAPPID @"1336806206"
@interface VastAppStoreGradeTools : NSObject

/**
 * 跳转到AppStore, 可评分评论, 无次数限制
 */
+ (void)goAppStoreGradeAppId:(NSString *)appId;

/**
 * 在APP内部加载App Store 展示APP信息，但不能直接跳转到评论编辑页面。
 * 再加载处App Store展示页面后，需要手动点击 评论→ 撰写评论
 
 要求：导入#import <StoreKit/StoreKit.h>
 遵循<SKStoreProductViewControllerDelegate>协议
 实现代理方法
 //Appstore 取消按钮的回调
 -(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
     [viewController dismissViewControllerAnimated:YES completion:nil];
 }
 */
- (void)inAppGradeBy:(UIViewController *)currentVc withAppId:(NSString *)appId;

/**
 一句话实现在App内直接评论了。然而需要注意的是：打开次数一年不能多于3次。（当然开发期间可以无限制弹出，方便测试）
 适用于iOS 10.3以上版本
 */
+ (void)inAppGradeByThirdOnceYear;
@end

NS_ASSUME_NONNULL_END
