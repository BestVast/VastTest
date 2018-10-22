//
//  ParseDocViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/22.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "ParseDocViewController.h"

@interface ParseDocViewController ()

@end

@implementation ParseDocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self parseDoc];
    self.view.backgroundColor = [UIColor cyanColor];
}
- (void)parseDoc {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bookmarks_2018_10_22.html" ofType:@""];
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        DLog(@"error->%@", error.localizedDescription);
    } else {
        NSArray *arr = [content componentsSeparatedByString:@"\n"];
        NSMutableArray *allData = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < arr.count; i++) {
//            DLog(@"index-%ld\ncontent->%@", i, arr[i]);
            NSString *string = arr[i];
            if ([string containsString:@"HREF=\""]) {
                NSString *regularStr1 = [NSString stringWithFormat:@"HREF=\".*\" ADD_DATE"];
                NSString *url = [self regularContent:string byRegularStr:regularStr1];
                if (url && url.length > 16) {
                    url = [url substringWithRange:NSMakeRange(6, url.length - 16)];
                    NSString *regularStr2 = [NSString stringWithFormat:@"\">.*</A>"];
                    NSString *name = [self regularContent:string byRegularStr:regularStr2];
                    if (name && name.length > 6) {
                        name = [name substringWithRange:NSMakeRange(2, name.length - 6)];
                        NSString *result = [NSString stringWithFormat:@"[%@](%@)", name, url];
                        [allData addObject:result];
                        NSLog(@"%@", result);
                    }
                }
            }
        }
        NSString *data = [allData componentsJoinedByString:@"\n\n"];
        NSString *path1 = [NSHomeDirectory() stringByAppendingString:@"/text.md"];
        DLog(@"path-%@", path1);
        [data writeToFile:path1 atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            DLog(@"%@", error.localizedDescription);
            [allData writeToFile:path1 atomically:YES];
        }
    }
}

- (NSString *)regularContent:(NSString *)content byRegularStr:(NSString *)regularStr {
    NSError *error;
    NSRegularExpression *expresstion = [NSRegularExpression regularExpressionWithPattern:regularStr options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    if (error) {
        DLog(@"error->%@", error.localizedDescription);
        return nil;
    }
    NSArray *resultArray = [expresstion matchesInString:content options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, content.length)];
    NSMutableArray *resultArr = [NSMutableArray new];
    if (resultArray && resultArray.count) {
        for (NSTextCheckingResult *textCheck in resultArray) {
            [resultArr addObject:[content substringWithRange:textCheck.range]];
        }
        return [resultArr lastObject];
    }
    DLog(@"0");
    return nil;
}
@end
