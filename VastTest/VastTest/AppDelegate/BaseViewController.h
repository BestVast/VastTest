//
//  BaseViewController.h
//  VastTest
//
//  Created by GoodSrc on 2018/7/31.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
// 返回上一层
- (void)backUpper;

// view的宽度
- (CGFloat)viewWidth;
@end

NS_ASSUME_NONNULL_END
