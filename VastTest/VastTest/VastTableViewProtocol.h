//
//  VastTableViewProtocol.h
//  VastTest
//
//  Created by GoodSrc on 2018/9/5.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SelectCellBlock) (NSIndexPath *indexPath, id obj);
NS_ASSUME_NONNULL_BEGIN

@interface VastTableViewProtocol : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy)   SelectCellBlock cellBlock;

// 初始化方法
- (instancetype)initWithDataSource:(NSMutableArray *)dataSource;
@end

NS_ASSUME_NONNULL_END
