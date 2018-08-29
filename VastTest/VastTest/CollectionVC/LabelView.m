//
//  LabelView.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "LabelView.h"
#define lineGap   10
#define columnGap 10
@implementation LabelView
{
    CGRect  _previousRect;
    CGFloat _parentWidth;
}
- (instancetype)initWithTitle:(NSString *)title bySymbol:(LabelHeaderSymbol)symbol byFontSize:(CGFloat)fontSize byPreviousFrame:(CGRect)previousRect byParentWidth:(CGFloat)width {
    if (self = [super init]) {
        self.title = title;
        self.symbol = symbol;
        self.fontSize = fontSize;
        _previousRect = previousRect;
        _parentWidth = width;
        self.backgroundColor = [UIColor cyanColor];
        self.labelWidth = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize]}].width;
        if (_previousRect.origin.x + _previousRect.size.width + lineGap + self.labelWidth < _parentWidth) {
            self.frame = CGRectMake(CGRectGetMaxX(_previousRect) + (_previousRect.size.width > 0 ? lineGap : 0), _previousRect.origin.y, self.labelWidth, 20);
        } else {
            self.frame = CGRectMake(0, CGRectGetMaxY(_previousRect) + lineGap, self.labelWidth, 20);
        }
    }
    return self;
}

@end
