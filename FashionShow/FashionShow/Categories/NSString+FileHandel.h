//
//  NSString+FileHandel.h
//  FashionShow
//
//  Created by zx on 15/3/10.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FileHandel)


+(BOOL)deleteCachesWithPath:(NSString *)path;

+(long)fileSizeForDir:(NSString*)path;

@end
