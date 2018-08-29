//
//  GTagSimpleCollectionHeadView.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "GTagSimpleCollectionHeadView.h"

@implementation GTagSimpleCollectionHeadView
{
    UILabel *_titleLabel;
    UIButton *_editButton;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self uiConfig];
    }
    return self;
}

/**
 点击 编辑 按钮回调事件
 */
- (void)clickButton {
    if (self.clickBtnCallback) {
        self.clickBtnCallback(_btnTitle);
    }
}
- (void)uiConfig {
    self.backgroundColor = UIColorFromRGBA(0xf2f2f2, 1.0);
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 15, 100, 17)];
    _titleLabel.font = [UIFont systemFontOfSize:TagHeadFontSize];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editButton.frame = CGRectMake(SCREEN_WIDTH - 15 - 70, 15, 70, 17);
    _editButton.titleLabel.font = [UIFont systemFontOfSize:TagHeadFontSize];
    [_editButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _editButton.hidden = YES;
    [_editButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editButton];
    
}
- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
- (void)setBtnTitle:(NSString *)btnTitle {
    [_editButton setTitle:btnTitle forState:UIControlStateNormal];
    if (btnTitle && btnTitle.length) {
        _editButton.hidden = NO;
    } else {
        _editButton.hidden = YES;
    }
}

@end
