//
//  GTagLayoutHelper.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/16.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#ifndef GTagLayoutHelper_h
#define GTagLayoutHelper_h


/**
 tag布局类中，cell类型

 - TagCellStateAdd:    标签cell 带加号
 - TagCellStateDelete: 标签cell 带叉号
 - TagCellStateNone:   标签cell 无
 */
typedef NS_ENUM(NSInteger, TagCellState) {
    TagCellStateAdd = 1,
    TagCellStateDelete = 2,
    TagCellStateNone = 3,
};


/**
 tag布局类中，分组标头 类型

 - TagHeadStyleAll: 所有标签(10个)
 - TagHeadStyleMore: 更多标签
 - TagHeadStyleGroup: 分组标签(个) - 添加
 - TagHeadStyleHome: 首页标签 - 所有标签
 */
typedef NS_ENUM(NSInteger, TagHeadStyle) {
    TagHeadStyleAll = 1,
    TagHeadStyleMore = 2,
    TagHeadStyleGroup = 3,
    TagHeadStyleHome = 4,
};


/**
 tag布局类中，head类型集合
    分组标题类型-第一组
    分组标题类型-第二组
 */
typedef struct {
    TagHeadStyle first;
    TagHeadStyle second;
} TagHeadStyleCollection;


#pragma mark ==CollectionView FlowLayout 布局参数==
#define INTERITEMSPACING 10.0f
#define LINESPACING 10.0f
#define ItemHeight 30
#define AddItemWidth 74
#define ItemWidthExtra 6
#define Gap 10.f
#define Collection_Header_Height 47.f
#define TagFontSize 12
#define TagHeadFontSize 12
// https://www.jianshu.com/p/b65be17b2457

#endif /* GTagLayoutHelper_h */
