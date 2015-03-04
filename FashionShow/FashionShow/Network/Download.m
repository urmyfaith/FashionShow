//
//  Download.m
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "Download.h"

/**
 *  下载类
 1. 下载地址
 2.  请求方法类型
 3.  post请求的参数或者是请求体
 3. 下载得到的数据
 */
@implementation Download


/**
 *  开始下载
 *  post需要设置请求体
 *  get方法参数直接写在地址栏中.
 */
-(void)startDownloadData{
    
    NSURL *url = [[NSURL alloc]initWithString:_downloadURL];
    
    if ([_downloadRequestMethod isEqualToString:@"POST"]) {
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        NSData *data = [_postData_String dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        
       NSURLConnection *connection =  [[NSURLConnection alloc]initWithRequest:request
                                                                     delegate:self
                                                             startImmediately:YES];
    }
    if ([_downloadRequestMethod isEqualToString:@"GET"]) {
        
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
        NSURLConnection *conn =  [[NSURLConnection alloc]initWithRequest:request
                                                                delegate:self
                                                        startImmediately:YES];
    }
}

-(id)init{
    if (self = [super init]) {
        _downloadData = [[NSMutableData alloc]init];
    }
    return self;
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"收到服务器响应");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"接收服务器响应数据...");
    [_downloadData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"接收数据完成");
    [_delegate downloadFinishWithDownload:self];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"下载失败! error=%@",error);
}

-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    NSLog(@"发送数据: %d bytes/ %d bytes / %d bytes",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
}

@end
