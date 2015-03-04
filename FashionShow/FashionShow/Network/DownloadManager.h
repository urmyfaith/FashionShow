//
//  DownloadManager.h
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Download.h"

/**
 *  下载管理类
 */
@interface DownloadManager : NSObject<DownloadDelegate>

/**
 *  添加下载任务
 *
 *  @param downloadURL           下载地址
 *  @param downloadRequestMethod 请求方法
 *  @param postData_string       post请求体
 */
-(void)addDownloadWithDownloadURL:(NSString *)downloadURL
          andDownloadResqustMethod:(NSString *)downloadRequestMethod
                andPostDataString:(NSString *)postData_string;

/**
 *  返回下载数据
 *
 *  @param urlIdentifier 区分每个请求的urlIdentifier
 *
 *  @return 下载完成的数据
 */
-(NSData *)getDownloadDataWithURLIdentifier:(NSString *)urlIdentifier;

/**
 *  单例类
 *
 *  @return 下载管理类
 */
+(DownloadManager *)sharedDownloadManager;

/**
 *  移除缓存了的数据
 *
 *  @param urlIdentifier url标志符
 *
 *  @return 是否清除成功
 */
-(BOOL)removeCachedDataWithURLIdentifier:(NSString *)urlIdentifier;

@end
