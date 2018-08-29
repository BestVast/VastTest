//
//  GTagFlowLayout.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "GTagFlowLayout.h"

@implementation GTagFlowLayout
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

/**
 * 准备布局item前调用，我们要在这里面完成必要属性的初始化
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    //初始化行距间距
    self.minimumLineSpacing = LINESPACING;
    self.minimumInteritemSpacing = INTERITEMSPACING;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.content_Height = 0;
    self.delegate = self.collectionView.delegate;
    
    //初始化容器类对象
    [self.attributes removeAllObjects];
    [self.headerAttributes removeAllObjects];
    self.headerAttributes = [[NSMutableArray alloc] init];
    self.attributes = [[NSMutableDictionary alloc] init];
    
    self.origin_Y = Gap;
    
    //遍历所有item 获取位置信息并进行存储
    NSUInteger sections = [self.collectionView numberOfSections];
    for (NSInteger i = 0; i < sections; i++) {
        CGSize size;
        size = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:i];
        if (size.width && size.height) {
            CGRect headerFrame;
            if (i == 0) {
                headerFrame = CGRectMake(0, 0, size.width, size.height);
                self.origin_Y += headerFrame.size.height;
            } else {
                self.origin_Y += ItemHeight + Gap;
                headerFrame = CGRectMake(0, self.origin_Y, size.width, size.height);
                self.origin_Y += Collection_Header_Height + Gap;
            }
            [self.headerAttributes addObject:NSStringFromCGRect(headerFrame)];
        }
       
        
        self.origin_X = 10.f;
        NSUInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < itemCount; j++) {
            [self layoutItemFrameAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
        }
    }
    self.origin_Y += (ItemHeight + Gap);
    self.content_Height = self.origin_Y;
}

/**
 * 用来设置每一个item的尺寸，然后和indexPath存储起来
 */
- (void)layoutItemFrameAtIndexPath: (NSIndexPath *)indexPath {
    CGFloat width;
    width = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath].width;
    // 在当前高度最低的列上面追加item并且存储位置信息
    CGRect frame;
    if (self.origin_X + width <= SCREEN_WIDTH - 20) {
        frame = CGRectMake(self.origin_X + (self.origin_X != Gap ? Gap : 0), self.origin_Y, width, ItemHeight);
        self.origin_X = CGRectGetMaxX(frame);
    } else {
        self.origin_Y = self.origin_Y + INTERITEMSPACING + ItemHeight;
        frame = CGRectMake(Gap, self.origin_Y, width, ItemHeight);
        self.origin_X = CGRectGetMaxX(frame);
    }
    [_attributes setValue: indexPath forKey: NSStringFromCGRect(frame)];
}

/**
 * 返回所有当前在可视范围内的item的布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect: (CGRect)rect {
    //获取当前所有可视item的indexPath。通过调用父类获取的布局属性数组会缺失一部分可视item的布局属性
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSString *rectStr in _attributes) {
        CGRect cellRect = CGRectFromString(rectStr);
        if (CGRectIntersectsRect(cellRect, rect)) {
            NSIndexPath *indexPath = _attributes[rectStr];
            [indexPaths addObject:indexPath];
        }
    }
    //获取当前要显示的所有item的布局属性并返回
    NSMutableArray *layoutAttributes = [NSMutableArray arrayWithCapacity:indexPaths.count];
    [indexPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = obj;
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }];
    [self.headerAttributes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }];
    return layoutAttributes;
}



/**
 * 返回对应indexPath的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    for (NSString *frame in _attributes) {
        if (_attributes[frame] == indexPath) {
            attributes.frame = CGRectFromString(frame);
            break;
        }
    }
    return attributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    attribute.frame = CGRectFromString(self.headerAttributes[indexPath.section]);
    return attribute;
}


/**
 * 设置collectionView的可滚动范围（瀑布流必要实现）
 */
- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(self.collectionView.frame.size.width, _origin_Y);
}

/**
 * 在collectionView的bounds发生改变的时候刷新布局
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectIntersectsRect(self.collectionView.bounds, newBounds);
}

@end
