//
//  NSString+FileHandel.m
//  FashionShow
//
//  Created by zx on 15/3/10.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "NSString+FileHandel.h"

@implementation NSString (FileHandel)


+(long)fileSizeForDir:(NSString*)path
{
    static long size = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize;
            //NSLog(@"flile=%@ \tsize=%llu",fullPath,fileAttributeDic.fileSize);
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    return size;
}

+(BOOL)deleteCachesWithPath:(NSString *)path{
    BOOL status = YES;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        status = [fileManager removeItemAtPath:fullPath error:nil];
    }
    return status;
}

@end
