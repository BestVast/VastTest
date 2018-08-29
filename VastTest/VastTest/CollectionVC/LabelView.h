//
//  LabelView.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

//label前面 加号/删除t
typedef NS_ENUM(NSInteger, LabelHeaderSymbol) {
    Add = 1,
    Delete = 2,
};
NS_ASSUME_NONNULL_BEGIN

@interface LabelView : UIView
@property (nonatomic, copy)     NSString *title;
@property (nonatomic, assign)   LabelHeaderSymbol symbol;
@property (nonatomic, assign)   CGFloat labelWidth;
@property (nonatomic, assign)   CGFloat fontSize;

- (instancetype)initWithTitle:(NSString *)title bySymbol:(LabelHeaderSymbol)symbol byFontSize:(CGFloat)fontSize byPreviousFrame:(CGRect)previousRect byParentWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
