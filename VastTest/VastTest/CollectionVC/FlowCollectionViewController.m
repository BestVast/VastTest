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
@interface FlowCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FlowCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", ]];
    
    [self.view addSubview:self.collectionView];
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
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
