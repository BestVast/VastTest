//
//  TestViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/12.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "TestViewController.h"
#import "UnitTestModel.h"
@interface TestViewController ()
@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self uiConfig];
    [self getData];
}
- (void)uiConfig {
    _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 355, 180)];
    [self.view addSubview:_showLabel];
    _showLabel.numberOfLines = 0;
    _showLabel.lineBreakMode = NSLineBreakByClipping;
    _showLabel.backgroundColor = [UIColor cyanColor];
}
- (void)getData {
    UnitTestModel *model = [UnitTestModel new];
    [model callbackDataSuccess:^(id  _Nonnull data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.showLabel.text = [NSString stringWithFormat:@"%@", data];
        });
    } error:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.showLabel.text = error.localizedDescription;
        });
    }];
}

@end
