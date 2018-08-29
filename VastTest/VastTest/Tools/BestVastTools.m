//
//  BestHaoTools.m
//  KingDraw
//
//  Created by GoodSrc on 2018/7/18.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import "BestVastTools.h"

@implementation BestVastTools

#pragma mark ==printf打印==
+ (void)printObj:(NSString *)obj {
    printf("%s", [[NSString stringWithFormat:@"%@\n", obj] UTF8String]);
}


#pragma mark ==数字字符串转十六进制数==
+ (unsigned long)getColorHexBy:(NSString *)string {
    unsigned long red = strtoul([string UTF8String],0,16);
    return red;
}


#pragma mark ==trim截取字符串头尾的空格和换行符==
+ (NSString *)trimStringWhitespaceAndNewlineCharBy:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 正则截取匹配的字符串 (数字)
 
 @param search 搜索的字符串
 @param content 被搜索的字符串
 @return 返回包含 [(数字)] 数组
 */
#pragma mark ==正则截取匹配的字符串(数字), 返回 [(数字), (数字), ...] 数组==
+ (NSArray *)regularSearchBracketAndNumString:(NSString *)search {
    NSString *regularStr = [NSString stringWithFormat:@"\\([0-9]+\\)"];;
    NSError *error;
    NSRegularExpression *expresstion = [NSRegularExpression regularExpressionWithPattern:regularStr options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    if (error) {
        DLog(@"%@", error.localizedDescription);
        return nil;
    }
    NSArray  *resultArray = [expresstion matchesInString:search options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, search.length)];
    if (resultArray && resultArray.count) {
        return (NSArray *)resultArray;
    }
    return nil;
}

#pragma mark ==打印所有文件名, 数据库中存储的文件名==
+ (void)logFileName {
    //读取全部数据
//    LKDBHelper *globalHelper=[DrawListModel getUsingLKDBHelper];
//    NSString *searchStr=[NSString stringWithFormat:@"select * from @t"];
//    NSMutableArray *searchResultArray=[globalHelper searchWithSQL:searchStr toClass:[DrawListModel class]];
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (DrawListModel *model in searchResultArray) {
//        [array addObject:[NSString stringWithFormat:@"%@.%@", model.fileName, model.fileExtention]];
//    }
//    NSArray *allFile = [[GFileUtil getInstance] readerAllFileName];
//    DLog(@"\n readerAllFileName-> %@ \n count->%d \n result->%@ \n count->%d", allFile, allFile.count, array, searchResultArray.count);
}

#pragma mark ==检测手机号是否有效==
+ (BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13, 14, 15, 16, 17, 18, 19开头，9个 \d 数字字符
    //NSString *phoneRegex = @"^(1[3-9])\\d{9}$";
    NSString *phoneRegex = @"^((13[0-9])|(15[0-9])|(18[0-9])|(17[0-9])|(14[0-9])|(16[0-9])|(19[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark ==检测密码是否有效==
+ (BOOL)checkPassWordInput:(NSString *)password{
    /// ^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$
    NSString *pattern = @"^[^\u4e00-\u9fa5]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

#pragma mark ==string width==
+ (CGFloat)widthGetByTitle:(NSString *)title {
    CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:TagFontSize]}].width;
    return width;
}

+ (CGFloat)heightGetByTitle:(NSString *)title {
    CGFloat height = [title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:TagFontSize]} context:nil].size.height;
    return height;
}

@end
