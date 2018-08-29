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
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@"登录页面MVVM", @"弹框页面", @"MenuViewController", @"Match", @"FMDB", @"Draw", @"RegularCollection", @"FlowCollection", @"ClassifyLabelView", @"HorizontalCollection"]];
    //[match](https://www.jianshu.com/p/2b599fc55011)
    [self uiConfig];
    
}

- (void)uiConfig {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*2/3) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.tableFooterView = [UIView new];
    if (@available(iOS 11.0, *)) {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        LoginViewController *listVc = [[LoginViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController: listVc];
        [self presentViewController:navi animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        ShowViewController *showVc = [[ShowViewController alloc] init];
        showVc.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
        [self presentViewController:showVc animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        MenuLabelViewController *listVc = [[MenuLabelViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController: listVc];
        [self presentViewController:navi animated:YES completion:nil];
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"Draw"]) {
        DrawViewController *drawVc = [[DrawViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:drawVc];
        [self presentViewController:navi animated:YES completion:nil];
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"RegularCollection"]) {
        VastCollectionViewController *vastVc = [[VastCollectionViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vastVc];
        [self presentViewController:navi animated:YES completion:nil];
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"FlowCollection"]) {
        FlowCollectionViewController *vastVc = [[FlowCollectionViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vastVc];
        [self presentViewController:navi animated:YES completion:nil];
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"ClassifyLabelView"]) {
        ClassifyLabelViewController *vastVc = [[ClassifyLabelViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vastVc];
        [self presentViewController:navi animated:YES completion:nil];
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"HorizontalCollection"]) {
        HorizontalCollectionViewController *vastVc = [[HorizontalCollectionViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vastVc];
        [self presentViewController:navi animated:YES completion:nil];
    } else if ([self.dataSource[indexPath.row] isEqualToString:@"Draw"]) {
        DrawViewController *vastVc = [[DrawViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vastVc];
        [self presentViewController:navi animated:YES completion:nil];
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

@end
