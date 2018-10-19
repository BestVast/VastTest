//
//  VastTableViewProtocol.h
//  VastTest
//
//  Created by GoodSrc on 2018/9/5.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SelectCellBlock) (UITableViewCell *cell, NSIndexPath *indexPath, id cellData);
NS_ASSUME_NONNULL_BEGIN

@interface VastTableViewProtocol : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy)   SelectCellBlock cellBlock;

// 初始化方法
- (instancetype)initWithDataSource:(NSMutableArray *)dataSource
                    CellIdentifier:(NSString *)identifier
                   configCellBlock:(SelectCellBlock)cellBlock;
@end

NS_ASSUME_NONNULL_END
