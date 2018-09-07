//
//  FmdbViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/9/7.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "FmdbViewController.h"
#import "FMDatabase.h"
@interface FmdbViewController ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation FmdbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (FMDatabase *)db {
    if (_db) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        path = [path stringByAppendingString:@"test.db"];
//        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
//
//        }
        _db = [FMDatabase databaseWithPath:path];
    }
    return _db;
}

@end
