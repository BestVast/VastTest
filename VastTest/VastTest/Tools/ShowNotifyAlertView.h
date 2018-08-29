//
//  ShowNotifyAlertView.h
//  KingDraw
//
//  Created by GoodSrc on 2018/8/27.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
// 「重要通知」view
@interface ShowNotifyAlertView : UIView
// title标题
@property (nonatomic, copy) NSString *title;
// 通知详情
@property (nonatomic, copy) NSString *details;
// 按钮文字
@property (nonatomic, copy) NSString *btnText;

// 点击“我知道了”按钮回调事件
@property (nonatomic, copy)   void (^clickButtonCallback) (NSString *urlStr);
@end
