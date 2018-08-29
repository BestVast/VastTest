//
//  LabelListView.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "LabelListView.h"
#import "LabelView.h"
@implementation LabelListView
{
    NSMutableArray *_btnArray;
}
- (instancetype)initWithFrame:(CGRect)frame byLabelArray:(NSMutableArray *)labelArray {
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = [UIColor redColor];
        self.labelArray = labelArray;
        _btnArray = [[NSMutableArray alloc] init];
        [self uiConfig];
    }
    return self;
}
- (void)uiConfig {
    for (NSInteger i = 0; i < self.labelArray.count; i++) {
        CGRect rect = CGRectMake(0, 0, 0, 0);
        if (i != 0) {
            LabelView *previousLabel = _btnArray.lastObject;
            rect = previousLabel.frame;
        }
        LabelView *label = [[LabelView alloc] initWithTitle:self.labelArray[i] bySymbol:Add byFontSize:14 byPreviousFrame:rect byParentWidth:SCREEN_WIDTH - 20];
        [self addSubview:label];
        [_btnArray addObject:label];
    }
    LabelView *label = _btnArray.lastObject;
    CGRect rect1 = self.frame;
    rect1.size.height = CGRectGetMaxY(label.frame) + 10;
    self.frame = rect1;
}

@end
