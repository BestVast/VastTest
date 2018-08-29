//
//  LabelListView.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelListView : UIView
@property (nonatomic, strong) NSMutableArray *labelArray;

@property (nonatomic, assign)   CGFloat listHeight;

- (instancetype)initWithFrame:(CGRect)frame byLabelArray:(NSMutableArray *)labelArray;
@end

NS_ASSUME_NONNULL_END
