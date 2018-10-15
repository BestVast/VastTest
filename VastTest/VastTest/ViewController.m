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
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) VastTableViewProtocol *protocol;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *first = [LanguageHandleTool getStringForKey:@"登录页面MVVM" withTable:@""];
    NSString *second = [LanguageHandleTool getStringForKey:@"弹框页面" withTable:@""];
    
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[first, second, @"MenuViewAndUIStackView", @"Match", @"FMDB", @"Draw", @"RegularCollection", @"FlowCollection", @"ClassifyLabelView", @"HorizontalCollection"]];
    //[match](https://www.jianshu.com/p/2b599fc55011)
    [self uiConfig];
    
}

- (void)uiConfig {
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.9) style:UITableViewStylePlain];
    //VastTableViewProtocol 必须为全局变量
    _protocol = [[VastTableViewProtocol alloc] initWithDataSource:self.dataSource];
    @WeakObj(self);
    _protocol.cellBlock = ^(NSIndexPath *indexPath, id obj) {
        [selfWeak selectCellCallback:indexPath];
    };
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
    if (indexPath.row == 0) {
        className = @"LoginViewController";
    } else if (indexPath.row == 1) {
//        className = @"LoginViewController";
        ShowViewController *showVc = [[ShowViewController alloc] init];
        showVc.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
        [self presentViewController:showVc animated:YES completion:nil];
        return;
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"MenuViewAndUIStackView"]) {
        className = @"MenuLabelViewController";
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"Draw"]) {
        className = @"DrawViewController";
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"RegularCollection"]) {
        className = @"VastCollectionViewController";
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"FlowCollection"]) {
        className = @"FlowCollectionViewController";
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"ClassifyLabelView"]) {
        className = @"ClassifyLabelViewController";
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"HorizontalCollection"]) {
        className = @"HorizontalCollectionViewController";
    }
    if (className && className.length) {
        Class class = NSClassFromString(className);
        UIViewController *listVc = [[class alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController: listVc];
        [self presentViewController:navi animated:YES completion:nil];
    }
}


- (void)injected {
    //在这里面写的代码才能看效果  写完后 command + s 就出效果了
    
    self.view.backgroundColor=[UIColor blueColor];
}

@end
