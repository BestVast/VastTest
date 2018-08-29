//
//  GTagCollectionViewCell.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/9.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "GTagCollectionViewCell.h"

@implementation GTagCollectionViewCell
{
    UILabel *_titleLabel;
    UIImageView *_stateIv;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        [self uiConfig];
    }
    return self;
}
- (void)uiConfig {
    self.contentView.backgroundColor = UIColorFromRGBA(0xd9d9d9, 1.0);
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.backgroundColor = self.contentView.backgroundColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:TagFontSize];
    [self.contentView addSubview:_titleLabel];
    
    _stateIv = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 12, 0, 12, 12)];
    [self.contentView addSubview:_stateIv];
}
- (void)setTitle:(NSString *)title {
    CGRect frame = _titleLabel.frame;
    frame.size.width = [BestVastTools widthGetByTitle:title] + ItemWidthExtra;
    _titleLabel.frame = frame;
    _titleLabel.text = title;
    _stateIv.frame = CGRectMake(frame.size.width - 12, 0, 12, 12);
}
- (void)setCellState:(TagCellState)cellState {
    _cellState = cellState;
    if (cellState == TagCellStateAdd) {
        _stateIv.backgroundColor = [UIColor redColor];
    } else if (cellState == TagCellStateDelete) {
        _stateIv.backgroundColor = [UIColor orangeColor];
    } else {
        _stateIv.backgroundColor = [UIColor grayColor];
    }
}

@end
