//
//  GTagFlowLayout.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTagFlowLayout : UICollectionViewFlowLayout 
@property (nonatomic, strong) NSMutableDictionary *attributes;

@property (nonatomic, strong) NSMutableArray *headerAttributes;
@property (nonatomic, assign) CGFloat origin_X;
@property (nonatomic, assign) CGFloat origin_Y;
@property (nonatomic, assign) CGFloat content_Height;

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;
@end

NS_ASSUME_NONNULL_END
