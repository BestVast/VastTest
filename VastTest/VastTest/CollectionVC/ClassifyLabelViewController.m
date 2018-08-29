//
//  ClassifyLabelViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/14.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "ClassifyLabelViewController.h"
#import "LabelListView.h"
@interface ClassifyLabelViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *hasAddArray;
@property (nonatomic, strong) NSMutableArray *notHasAddArray;
@end

@implementation ClassifyLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self uiConfig];
}

#pragma mark ==action==
#pragma mark ==notification==
#pragma mark ==UI==
- (void)uiConfig {
    LabelListView *listView = [[LabelListView alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 0) byLabelArray:self.hasAddArray];
    [self.view addSubview:listView];
}
#pragma mark ==getter setter==
- (NSMutableArray *)hasAddArray {
    if (!_hasAddArray) {
        _hasAddArray = [[NSMutableArray alloc] initWithArray:@[@"芳香类芳氢类", @"芳氢类芳氢类芳氢类", @"abcefg芳氢类芳氢类", @"芳香类芳氢类", @"芳氢类", @"abcefg", @"芳香类", @"芳氢类", @"abcefg", @"芳香类", @"芳氢类芳氢类", @"abcefg芳氢类", @"weiohgfdsdfghj", @"qwertyuioplkjhgfdsa"]];
    }
    return _hasAddArray;
}
@end
