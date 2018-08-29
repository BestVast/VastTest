//
//  GTagAddCollectionViewCell.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/16.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "GTagAddCollectionViewCell.h"

@implementation GTagAddCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self uiConfig];
    }
    return self;
}
- (void)uiConfig {
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = @"+";
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderWidth = 1;
    label.layer.borderColor = UIColorFromRGBA(0xd9d9d9, 1.0).CGColor;
    label.layer.cornerRadius = 2;
    label.layer.masksToBounds = YES;
    [self.contentView addSubview:label];
}
@end
