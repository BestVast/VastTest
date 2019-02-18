//
//  MasterViewController.m
//  SplitProject
//
//  Created by GoodSrc on 2019/2/18.
//  Copyright © 2019 GoodSrc. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()
@property (nonatomic,copy) NSArray *dataSource;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.splitViewController.viewControllers);
    self.dataSource = self.splitViewController.viewControllers;
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"Master";
    
    [self setupView];
}

- (void)setupView {
    NSArray *arr = @[@"DetailVc", @"FirstVc", @"SecondVc"];
    for (NSInteger i = 1; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor cyanColor];
        btn.frame = CGRectMake(10, 100 + 55 * i, 88, 45);
        btn.tag = 100 + i;
        [btn setTitle:arr[i - 1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)clickBtn:(UIButton *)button {
    DLog(@"%d", button.tag);
    [self.splitViewController showViewController:self.dataSource[button.tag - 100] sender:nil];
}

@end
