//
//  WaterFallsFlowLayout.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/13.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterFallsFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSMutableDictionary * attributes;

@property (nonatomic, strong) NSMutableArray * colArray;    
@end

NS_ASSUME_NONNULL_END
