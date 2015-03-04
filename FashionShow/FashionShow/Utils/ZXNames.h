//
//  ZXNames.h
//  FashionShow
//
//  Created by zx on 15/2/7.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXNames : NSObject


/**
 *  从文件读取姓名,存入数组
 *
 *  @param filename 文件名
 *  @param filetype 文件后缀
 *
 *  @return 姓名数组
 */
+(NSArray *)readNamesFromFilename:(NSString *)filename
                      andFiletype:(NSString *)filetype;

@end
