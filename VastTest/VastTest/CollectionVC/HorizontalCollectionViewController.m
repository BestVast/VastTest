//
//  HorizontalCollectionViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "HorizontalCollectionViewController.h"
#import "GTagLayoutView.h"

@interface HorizontalCollectionViewController () 
@property (nonatomic, strong) GTagLayoutView *layoutView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HorizontalCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:@[@"11234567654", @"1dfghgmnbcf", @"1fasdfefgvfsd", @"1w55452453", @"1gdsfbrgfdv", @"134567kjhgfg", @"1dfsf", @"13235", @"1345", @"1665433", @"芳香类芳氢类", @"芳氢类芳氢类芳氢类", @"abcefg芳氢类芳氢类", @"芳香类芳氢类", @"芳氢类", @"abcefg", @"芳香类", @"芳氢类", @"abcefg", @"芳香类", @"芳氢类芳氢类", @"abcefg芳氢类", @"weiohgfdsdfghj", @"qwertyuioplkjhgfdsa"]];
    NSMutableArray *array0 = [array mutableCopy];
    NSMutableArray *array1 = [array mutableCopy];
    
    self.dataSource = [[NSMutableArray alloc] init];
    [self.dataSource addObject:array0];
//    [self.dataSource addObject:array1];
    [self.view addSubview:self.layoutView];
    
    self.layoutView.showAddSymbol = YES;
    self.layoutView.dataSource = self.dataSource;
    TagHeadStyleCollection collection;
    collection.first = TagHeadStyleHome;
    collection.second = TagHeadStyleMore;
    self.layoutView.headCollection = collection;
    
    @WeakObj(self);
    self.layoutView.clickHeader = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull currentIp, NSString * _Nonnull btnTitle) {
        
        //点击按钮回调
    };
    self.layoutView.clickCell = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull currentIp) {
        if (selfWeak.dataSource.count == 1) {
            if ([selfWeak.layoutView judgeIsShowAddCell:currentIp]) {
                NSMutableArray *array0 = selfWeak.dataSource[0];
                [array0 addObject:@"88888888"];
                [collectionView reloadData];
            } else {
                NSMutableArray *array0 = selfWeak.dataSource[0];
                [array0 removeObjectAtIndex:currentIp.row];
                [collectionView reloadData];
            }
        } else {
            NSMutableArray *array0 = selfWeak.dataSource[0];
            NSMutableArray *array1 = selfWeak.dataSource[1];
            if (currentIp.section == 0) {
                NSString *string = array0[currentIp.row];
                [array0 removeObjectAtIndex:currentIp.row];
                [array1 insertObject:string atIndex:0];
                NSIndexPath *lastIp = [NSIndexPath indexPathForRow:0 inSection:1];
                [collectionView moveItemAtIndexPath:currentIp toIndexPath:lastIp];
                [selfWeak.layoutView setTagCellState:TagCellStateDelete indexPath:lastIp];
            } else if (currentIp.section == 1) {
                NSString *string = array1[currentIp.row];
                [array1 removeObjectAtIndex:currentIp.row];
                [array0 addObject:string];
                NSIndexPath *lastIp = [NSIndexPath indexPathForRow:array0.count - 1  inSection:0];
                [collectionView moveItemAtIndexPath:currentIp toIndexPath:lastIp];
                [selfWeak.layoutView setTagCellState:TagCellStateAdd indexPath:lastIp];
            }
        }
    };
}
- (UIView *)layoutView {
    if (!_layoutView) {
        _layoutView = [[GTagLayoutView alloc] initWithFrame:self.view.bounds];
        _layoutView.backgroundColor = [UIColor whiteColor];
    }
    return _layoutView;
}

@end
