//
//  FlowCollectionViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/13.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "FlowCollectionViewController.h"
#import "WaterFallsFlowLayout.h"
#import "GTagCollectionViewCell.h"
#import "LanguageHandleTool.h"
#import "ViewController.h"
#import "LanguageXibTestView.h"
@interface FlowCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FlowCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = DLocal(@"设置语言");
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@"简体中文", @"English", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", ]];
    
    [self.view addSubview:self.collectionView];
    
    LanguageXibTestView *xib = [[LanguageXibTestView alloc] init];
    //[[[NSBundle mainBundle] loadNibNamed:@"LanguageXibTestView" owner:self options:nil] firstObject];
    [self.view addSubview:xib];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(10, 300, 120, 120);
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // en.lproj  zh-Hans.lproj
    // en        zh-Hans-US
    DLog(@"修改前语言: %@ \n", [LanguageHandleTool getLanguage]);
    if (indexPath.row == 0) {
        [LanguageHandleTool setLocalLanguage:Language_Chinese];
    } else if (indexPath.row == 1) {
        [LanguageHandleTool setLocalLanguage:Language_En];
    } else {
        return;
    }
    [LanguageHandleTool resetRootViewController];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.title = self.dataSource[indexPath.row];
    return cell;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WaterFallsFlowLayout *flowLayout = [[WaterFallsFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[GTagCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}
@end
