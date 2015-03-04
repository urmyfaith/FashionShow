//
//  ZXNames.m
//  FashionShow
//
//  Created by zx on 15/2/7.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXNames.h"

@implementation ZXNames

/**
 *  从文件读取姓名,存入数组
 *
 *  @param filename 文件名
 *  @param filetype 文件后缀
 *
 *  @return 姓名数组
 */
+(NSArray *)readNamesFromFilename:(NSString *)filename
                      andFiletype:(NSString *)filetype{
    
    NSMutableArray *namesArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:filename ofType:filetype];
    
    NSString *string = [NSString stringWithContentsOfFile:filepath
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil];
    NSArray *linesArray = [string componentsSeparatedByString:@"\n"];
    
    for (NSString *one_line_string in linesArray) {
        
        NSString *searchText = one_line_string;
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]+" options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
        if (result) {
            [namesArray addObject:[searchText substringWithRange:result.range]];
        }
    }
    return namesArray;
}

@end
