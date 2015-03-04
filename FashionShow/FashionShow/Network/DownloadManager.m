//
//  DownloadManager.m
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "DownloadManager.h"



@implementation DownloadManager
{
    NSMutableDictionary *_taskQueue_mDict;
    NSMutableDictionary *_cachedDownloadedData_mDict;
}

/**
 *  单例类
 *
 *  @return 下载管理类
 */

+(DownloadManager *)sharedDownloadManager{
    static DownloadManager *_sharedDownloadManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDownloadManager = [[DownloadManager alloc]init];
    });
    return _sharedDownloadManager;
}


-(id)init{
    self = [super init];
    if (self) {
        _taskQueue_mDict            = [[NSMutableDictionary alloc]init];
        _cachedDownloadedData_mDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}


/**
 *  添加下载任务
 *
 *  @param downloadURL           下载地址
 *  @param downloadRequestMethod 请求方法
 *  @param postData_string       post请求体
 */
-(void)addDownloadWithDownloadURL:(NSString *)downloadURL
         andDownloadResqustMethod:(NSString *)downloadRequestMethod
                andPostDataString:(NSString *)postData_string{
    
    NSString *urlIdentifier = [NSString stringWithFormat:@"%@%@",downloadURL,postData_string];
    
    if ([_cachedDownloadedData_mDict objectForKey:urlIdentifier]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:urlIdentifier object:nil];
    }
    else{
        if ([_taskQueue_mDict objectForKey:urlIdentifier]) {
            NSLog(@"%s [LINE:%d] downloading...", __func__, __LINE__);
        }
        else{
            
            Download *dl                = [[Download alloc]init];
            dl.downloadURL              = downloadURL;
            dl.downloadRequestMethod    = downloadRequestMethod;
            dl.postData_String          = postData_string;
            dl.delegate                 = self;
            dl.downloadURLIdentifier    = urlIdentifier;
            [dl startDownloadData];
            
            [_taskQueue_mDict setObject:dl forKey:urlIdentifier];
        }
    }
}

#pragma mark 代理方法:下载完成
/**
 *  下载完成方法
 * 1.从队列里移除,2.缓存数据 3.发送通知.
 *
 *  @param download 下载完成后的下载对象(里面有下载地址,下载得到的数据等)
 */
-(void)downloadFinishWithDownload:(Download *)download{

    
    [_taskQueue_mDict removeObjectForKey:download.downloadURLIdentifier];
    
    [_cachedDownloadedData_mDict setObject:download.downloadData forKey:download.downloadURLIdentifier];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:download.downloadURLIdentifier object:nil];
}

/**
 *  返回下载数据
 *
 *  @param downloadURL 下载地址
 *
 *  @return 下载完成的数据
 */
-(NSData *)getDownloadDataWithURLIdentifier:(NSString *)urlIdentifier{
    
    return [_cachedDownloadedData_mDict objectForKey:urlIdentifier];
}


/**
 *  移除缓存了的数据
 *
 *  @param urlIdentifier url标志符
 *
 *  @return 是否清除成功
 */
-(BOOL)removeCachedDataWithURLIdentifier:(NSString *)urlIdentifier{
    
    [_cachedDownloadedData_mDict removeObjectForKey:urlIdentifier];
    if ([_cachedDownloadedData_mDict objectForKey:urlIdentifier]) {
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}

@end
