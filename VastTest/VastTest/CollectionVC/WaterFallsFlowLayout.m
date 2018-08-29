//
//  WaterFallsFlowLayout.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/13.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//
#define COLUMNCOUNT 3

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define INTERITEMSPACING 10.0f

#define LINESPACING 10.0f

#define ITEMWIDTH ((SCREENWIDTH - (COLUMNCOUNT - 1)*INTERITEMSPACING) / 3)
// https://www.jianshu.com/p/b65be17b2457
#import "WaterFallsFlowLayout.h"

@implementation WaterFallsFlowLayout
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
    
    //初始化容器类对象
    self.attributes = [NSMutableDictionary dictionary];
    self.colArray = [NSMutableArray arrayWithCapacity:COLUMNCOUNT];
    for (NSInteger i = 0; i < COLUMNCOUNT; i++) {
        [self.colArray addObject:@(.0f)];
    }
    
    //遍历所有item 获取位置信息并进行存储
    NSUInteger sections = [self.collectionView numberOfSections];
    for (NSInteger i = 0; i < sections; i++) {
        NSUInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < itemCount; j++) {
            [self layoutItemFrameAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
        }
    }
}

/**
 * 用来设置每一个item的尺寸，然后和indexPath存储起来
 */
- (void)layoutItemFrameAtIndexPath: (NSIndexPath *)indexPath {
    // 获取列中最短的y坐标，col值
    NSInteger smallestCol = 0;
    CGFloat shortHeight = [_colArray[smallestCol] doubleValue];
    for (NSInteger col = 1; col < COLUMNCOUNT; col++) {
        if ([_colArray[col] doubleValue] < shortHeight) {
            smallestCol = col;
            shortHeight = [_colArray[col] doubleValue];
        }
    }
    
    // 在当前高度最低的列上面追加item并且存储位置信息
    CGRect frame = CGRectMake((smallestCol)*(INTERITEMSPACING + ITEMWIDTH), shortHeight + INTERITEMSPACING, ITEMWIDTH, 100 + arc4random() % 101);
    [_attributes setValue: indexPath forKey: NSStringFromCGRect(frame)];
    [_colArray replaceObjectAtIndex: smallestCol withObject: @(CGRectGetMaxY(frame))];
    
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


/**
 * 设置collectionView的可滚动范围（瀑布流必要实现）
 */
- (CGSize)collectionViewContentSize {
    CGFloat maxHeight = [_colArray[0] floatValue];
    for (NSInteger col = 1; col < _colArray.count; col++) {
        if ([_colArray[col] floatValue]> maxHeight) {
            maxHeight = [_colArray[col] floatValue] + 30.f;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}

/**
 * 在collectionView的bounds发生改变的时候刷新布局
*/
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectIntersectsRect(self.collectionView.bounds, newBounds);
}

@end
