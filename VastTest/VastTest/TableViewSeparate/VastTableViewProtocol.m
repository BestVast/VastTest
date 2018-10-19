//
//  VastTableViewProtocol.m
//  VastTest
//
//  Created by GoodSrc on 2018/9/5.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "VastTableViewProtocol.h"

@implementation VastTableViewProtocol
- (instancetype)initWithDataSource:(NSMutableArray *)dataSource CellIdentifier:(nonnull NSString *)identifier configCellBlock:(nonnull SelectCellBlock)cellBlock {
    if (self = [super init]) {
        DLog(@"%@", dataSource);
        self.dataSource = dataSource;
        if (cellBlock) {
            self.cellBlock = cellBlock;
        }
    }
    return self;
}


#pragma mark ==UITableViewDelegate==
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.cellBlock) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.cellBlock(cell ,indexPath, nil);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"列表页面";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

#pragma mark ==UITableViewDataSource==
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

@end
