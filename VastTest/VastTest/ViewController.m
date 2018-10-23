//
//  ViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/7/24.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "ViewController.h"
#import "ShowViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "LoginViewController.h"
#import "VastAlertView.h"
#import "MenuLabelViewController.h"
#import "DrawViewController.h"
#import "VastCollectionViewController.h"
#import "FlowCollectionViewController.h"
#import "ClassifyLabelViewController.h"
#import "HorizontalCollectionViewController.h"
#import "ShowNotifyAlertView.h"
#import "DrawViewController.h"
#import "VastTableViewProtocol.h"
#import "LanguageHandleTool.h"
#import "KVCTestViewController.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) VastTableViewProtocol *protocol;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self dataConfig];
    //[正则表达式](https://www.jianshu.com/p/2b599fc55011)
    [self uiConfig];
    
}

- (void)dataConfig {
    NSString *first = [LanguageHandleTool getStringForKey:@"登录页面MVVM" withTable:@""];
    NSString *second = [LanguageHandleTool getStringForKey:@"弹框页面" withTable:@""];
    
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[first, second, @"MenuViewAndUIStackView", @"Match", @"FMDB", @"Draw", @"RegularCollection", @"FlowCollection and 设置App语言", @"ClassifyLabelView", @"HorizontalCollection", @"KVC and 防止连续点击btn", @"ParseDocViewController"]];
}
- (void)uiConfig {
    self.navigationItem.title = @"列表页面";
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SCREEN_HEIGHT*0.9) style:UITableViewStylePlain];
    
    @WeakObj(self);
    //VastTableViewProtocol 必须为全局变量
    _protocol = [[VastTableViewProtocol alloc] initWithDataSource:self.dataSource CellIdentifier:@"cell" configCellBlock:^(UITableViewCell *cell, NSIndexPath *indexPath, id cellData) {
        [selfWeak selectCellCallback:indexPath];
    }];
    table.delegate = _protocol;
    table.dataSource = _protocol;
    [self.view addSubview:table];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.tableFooterView = [UIView new];
    [table reloadData];
    if (@available(iOS 11.0, *)) {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)selectCellCallback:(NSIndexPath *)indexPath {
    NSString *className;
    NSString *indexName = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
        className = @"LoginViewController";
    } else if (indexPath.row == 1) {
//        className = @"LoginViewController";
        ShowViewController *showVc = [[ShowViewController alloc] init];
        showVc.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
        [self presentViewController:showVc animated:YES completion:nil];
        return;
    } else if ([indexName isEqualToString:@"MenuViewAndUIStackView"]) {
        className = @"MenuLabelViewController";
    } else if ([indexName isEqualToString:@"Draw"]) {
        className = @"DrawViewController";
    } else if ([indexName isEqualToString:@"RegularCollection"]) {
        className = @"VastCollectionViewController";
    } else if ([indexName hasPrefix:@"FlowCollection"]) {
        className = @"FlowCollectionViewController";
    } else if ([indexName isEqualToString:@"ClassifyLabelView"]) {
        className = @"ClassifyLabelViewController";
    } else if ([indexName isEqualToString:@"HorizontalCollection"]) {
        className = @"HorizontalCollectionViewController";
    } else if ([indexName containsString:@"KVC"]) {
        className = @"KVCTestViewController";
    } else if ([indexName containsString:@"ParseDocViewController"]) {
        className = @"ParseDocViewController";
    }
    if (className && className.length) {
        Class class = NSClassFromString(className);
        UIViewController *listVc = [[class alloc] init];
//        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController: listVc];
//        [self presentViewController:navi animated:YES completion:nil];
        //获取详细控制器
        UINavigationController *detailNAV = [self.splitViewController.viewControllers lastObject];
        detailNAV.viewControllers = @[listVc];
    }
}


- (void)injected {
    //在这里面写的代码才能看效果  写完后 command + s 就出效果了
    
    self.view.backgroundColor=[UIColor blueColor];
}

@end
