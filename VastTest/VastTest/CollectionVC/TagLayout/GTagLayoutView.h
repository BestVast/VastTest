//
//  GTagLayoutView.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/16.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GTagFlowLayout.h"
@class GTagCollectionViewCell;
// 
NS_ASSUME_NONNULL_BEGIN

typedef void (^ClickCellCallback) (UICollectionView *collectionView, NSIndexPath *currentIp);
typedef void (^ClickHeadCallback) (UICollectionView *collectionView, NSIndexPath *currentIp, NSString *btnTitle);
@interface GTagLayoutView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;

//布局
@property (nonatomic, strong) GTagFlowLayout *flowLayout;


//赋值时，先赋值showAddSymbol，再赋值dataSource，最后赋值标题类型
@property (nonatomic, assign)   TagHeadStyleCollection headCollection;

//数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
// 第一个分组，是否需要加号展示
@property (nonatomic, assign)   BOOL showAddSymbol;


//点击cell回调
@property (nonatomic, copy)   ClickCellCallback clickCell;
//点击head 编辑 按钮回调
@property (nonatomic, copy)   ClickHeadCallback clickHeader;


/**
 * 判断是否显示 添加的 加号cell
 */
- (BOOL)judgeShowAddCell:(NSInteger)section;

/**
 * 判断是否是 添加的 加号cell
 */
- (BOOL)judgeIsShowAddCell:(NSIndexPath *)indexPath;

/**
 * 修改cell状态
 */
- (void)setTagCellState:(TagCellState)cellState indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
