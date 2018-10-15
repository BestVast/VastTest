//
//  LanguageXibTestView.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/15.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "LanguageXibTestView.h"

@implementation LanguageXibTestView
- (instancetype)init {
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LanguageXibTestView" owner:self options:nil] lastObject];
    }
    return self;
}

@end
