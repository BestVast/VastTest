//
//  UIButton+VastRepeatClick.h
//  VastTest
//
//  Created by GoodSrc on 2018/10/17.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 防止button重复点击
 */
@interface UIButton (VastRepeatClick)

/**
 间隔时间
 */
@property (nonatomic, assign)   NSTimeInterval timeInterval;

/**
 是否忽略点击事件，YES为忽略点击事件，NO为可以点击
 */
@property (nonatomic, assign)   BOOL           isIgnoreEvent;
@end

NS_ASSUME_NONNULL_END
