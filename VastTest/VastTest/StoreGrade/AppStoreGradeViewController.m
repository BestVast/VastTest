//
//  AppStoreGradeViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/24.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "AppStoreGradeViewController.h"
#import <StoreKit/StoreKit.h>
#import "VastAppStoreGradeTools.h"
@interface AppStoreGradeViewController () <SKStoreProductViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *GoAppStore;
@property (weak, nonatomic) IBOutlet UIButton *InApp;
@property (weak, nonatomic) IBOutlet UIButton *InAppThirdOnceYear;

@end

@implementation AppStoreGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //https://itunes.apple.com/cn/lookup?id=1336806206
}

- (IBAction)goAppStoreGrade:(id)sender {
    [VastAppStoreGradeTools goAppStoreGradeAppId:KAPPID];
}

- (IBAction)inAppGrade:(id)sender {
    VastAppStoreGradeTools *vast = [[VastAppStoreGradeTools alloc] init];
    [vast inAppGradeBy:self withAppId:KAPPID];
}

- (IBAction)inAppGradeByThirdOnceYear:(id)sender {
    [VastAppStoreGradeTools inAppGradeByThirdOnceYear];
}

//Appstore 取消按钮的回调
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
