//
//  GTagCollectionViewCell.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/9.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTagCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy)     NSString *title;
@property (nonatomic, assign)   TagCellState cellState;
- (void)animateAffine;
@end
