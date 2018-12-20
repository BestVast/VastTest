//
//  GChartViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/12/20.
//  Copyright © 2018 GoodSrc. All rights reserved.
//

#import "GChartViewController.h"
#import "GpaletteView.h"
#import "GPieChartView.h"
@interface GChartViewController ()

@end

@implementation GChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GpaletteView *palette = [[GpaletteView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT/2 - 80)];
    [self.view addSubview:palette];
    
    GPieChartView *pie = [[GPieChartView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    [self.view addSubview:pie];
}

@end
