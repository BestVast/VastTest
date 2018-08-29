//
//  GTagLayoutView.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/16.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "GTagLayoutView.h"
#import "GTagCollectionViewCell.h"
#import "GTagSimpleCollectionHeadView.h"
#import "GTagAddCollectionViewCell.h"
static NSString *const identifier = @"rowCell";
static NSString *const headerIdentifier = @"header";
@implementation GTagLayoutView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}
#pragma mark ==action==

/**
 * 判断是否显示 添加的 加号cell
 */
- (BOOL)judgeShowAddCell:(NSInteger)section {
    if (self.showAddSymbol
        && section == 0
        && self.dataSource.count == 1) {
        return YES;
    }
    return NO;
}

/**
 * 判断是否是 添加的 加号cell
 */
- (BOOL)judgeIsShowAddCell:(NSIndexPath *)indexPath {
    NSArray *array = self.dataSource[indexPath.section];
    if (self.showAddSymbol
        && self.dataSource.count == 1
        && array.count == indexPath.row) {
        return YES;
    }
    return NO;
}
- (void)setTagCellState:(TagCellState)cellState indexPath:(NSIndexPath *)indexPath {
    GTagCollectionViewCell *cell = (GTagCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.cellState = cellState;
}

#pragma mark ==KVO==
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //观察 回调collectionView高度
    if ([keyPath isEqualToString:@"content_Height"]) {
        CGFloat new = [change[@"new"] doubleValue];
        if (new > 0
            && new < SCREEN_HEIGHT) {
            CGRect frame = _collectionView.frame;
            frame.size.height = new + kNavBarHeight ;
            _collectionView.frame = frame;
        }
    }
}
- (void)longPress:(UILongPressGestureRecognizer *)longGesture {
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan: {
//            CGPoint point = [longGesture locationInView:_collectionView];
//            NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:point];
//            GTagCollectionViewCell *cell = (GTagCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//            cell.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }
            break;
        case UIGestureRecognizerStateChanged: {
            
        }
            break;
        case UIGestureRecognizerStateEnded: {
            
        }
            break;
        default:
            break;
    }
}


#pragma mark ==UICollectionViewDataSource==
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = self.dataSource[section];
    if ([self judgeShowAddCell:section]) {
        return array.count + 1;
    }
    return array.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.dataSource[indexPath.section];
    if ([self judgeIsShowAddCell:indexPath]) {
        [collectionView registerClass:[GTagAddCollectionViewCell class] forCellWithReuseIdentifier:@"addCell"];
        GTagAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addCell" forIndexPath:indexPath];
        return cell;
    }
    GTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.title = array[indexPath.row];
    if (indexPath.section == 0) {
        cell.cellState = TagCellStateAdd;
    } else {
        cell.cellState = TagCellStateDelete;
    }
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        GTagSimpleCollectionHeadView *reusable = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        if (indexPath.section == 0) {
            if (_headCollection.first == TagHeadStyleAll) {
                reusable.title = @"所有标签";//[NSString stringWithFormat:@"第%ld组", indexPath.section + 1];
            } else if (_headCollection.first == TagHeadStyleHome) {
                reusable.title = @"分组标签";
                reusable.btnTitle = @"标签管理>";
                reusable.clickBtnCallback = ^(NSString * _Nonnull btnTitle) {
                    if (self.clickHeader) {
                        self.clickHeader(collectionView, indexPath, btnTitle);
                    }
                };
            } else if (_headCollection.first == TagHeadStyleMore) {
                reusable.title = @"更多标签";
            } else if (_headCollection.first == TagHeadStyleGroup) {
                reusable.title = @"分组标签";
            }
        } else {
            if (_headCollection.second == TagHeadStyleMore) {
                reusable.title = @"更多标签";
            }
        }
        
        return reusable;
    }
    return nil;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark ==UICollectionViewDelegateFlowLayout==
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title;
    NSArray *array = self.dataSource[indexPath.section];
    if ([self judgeIsShowAddCell:indexPath]) {
        return CGSizeMake(AddItemWidth, ItemHeight);
    }
    title = array[indexPath.row];
    CGFloat width = [BestVastTools widthGetByTitle:title] + ItemWidthExtra;
    return CGSizeMake(width, ItemHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 && _headCollection.first == 0) {
        return CGSizeZero;
    } else if (section == 1 && _headCollection.second == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(SCREEN_WIDTH, Collection_Header_Height);
}

#pragma mark ==UICollectionViewDelegate==
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_clickCell) {
        _clickCell(collectionView, indexPath);
    }
}

#pragma mark ==setter/getter==
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flowLayout = [[GTagFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[GTagCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        [_collectionView registerClass:[GTagSimpleCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//        [_collectionView addGestureRecognizer:longPress];
        
        [_flowLayout addObserver:self forKeyPath:@"content_Height" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    return _collectionView;
}


- (void)setHeadCollection:(TagHeadStyleCollection)headCollection {
    _headCollection = headCollection;
}
- (void)setShowAddSymbol:(BOOL)showAddSymbol {
    _showAddSymbol = showAddSymbol;
}
- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    _collectionView.alwaysBounceVertical = (_dataSource.count != 1);
    [_collectionView reloadData];
}

- (void)dealloc {
    [_flowLayout removeObserver:self forKeyPath:@"content_Height"];
}

@end
