//
//  VastAppStoreGradeTools.m
//  KingDraw
//
//  Created by GoodSrc on 2018/10/24.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import "VastAppStoreGradeTools.h"
#import <StoreKit/StoreKit.h>

@interface VastAppStoreGradeTools()
@end
@implementation VastAppStoreGradeTools
{
    SKStoreProductViewController *storeProductViewController;
}
/**
 * 跳转到AppStore, 可评分评论, 无次数限制
 */
+ (void)goAppStoreGradeAppId:(NSString *)appId {
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appId];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
/**
 * 在APP内部加载App Store 展示APP信息，但不能直接跳转到评论编辑页面。
 * 再加载处App Store展示页面后，需要手动点击 评论→ 撰写评论
*/
- (void)inAppGradeBy:(UIViewController *)currentVc withAppId:(nonnull NSString *)appId {
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    storeProductViewController = [[SKStoreProductViewController alloc] init];
    storeProductViewController.delegate = currentVc;
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:appId} completionBlock:^(BOOL result, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (error) {
            DLog(@"error %@ with userInfo %@",error,[error userInfo]);
        }
        else {
            [currentVc presentViewController:self->storeProductViewController animated:YES completion:nil];
        }
    }];
}


/**
 一句话实现在App内直接评论了。然而需要注意的是：打开次数一年不能多于3次。（当然开发期间可以无限制弹出，方便测试）
 适用于iOS 10.3以上版本
 */
+ (void)inAppGradeByThirdOnceYear {
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"版本不支持此方法"];
    }
}
@end
