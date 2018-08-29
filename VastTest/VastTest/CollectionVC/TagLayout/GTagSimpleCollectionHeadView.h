//
//  GTagSimpleCollectionHeadView.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^EditButtonCallback) (NSString *btnTitle);
@interface GTagSimpleCollectionHeadView : UICollectionReusableView
//左侧label title
@property (nonatomic, copy) NSString *title;
//右侧button title
@property (nonatomic, copy) NSString *btnTitle;

//编辑 按钮回调事件
@property (nonatomic, copy)   EditButtonCallback clickBtnCallback;
@end

NS_ASSUME_NONNULL_END
