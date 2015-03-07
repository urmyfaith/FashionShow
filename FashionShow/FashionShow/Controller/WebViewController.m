//
//  WebViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController
{
    UIWebView *_webView ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getArticleURLPath];

    
    _webView= [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    NSURL *url = [NSURL URLWithString:_urlIdentifier];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    [self createButtomView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"Loading..."];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
   self.article_title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark 拼接网页地址

-(void)getArticleURLPath{
    NSString *postData_string = @"action=article&id=%@&uid=11111111&e=a2ae6a1b2c1a6aa2faa07bf2bd57ab37&platform=a&pid=10129&mobile=HUAWEI+P6-C00&fontsize=m";
    postData_string = [NSString stringWithFormat:postData_string,_article_id];
    
    //注意,这里地址中间有一个问号,将地址和参数分割开来
    _urlIdentifier = [NSString stringWithFormat:@"%@?%@",zxAPI_FULLPATH,postData_string];
}

-(void)createButtomView{
    [self createButtomViewWithImagesArray:@[@"内文返回_1",@"non-exist-image",@"分享_1",@"收藏_1",@"评论_1"]
                                 andClass:self
                                   andSEL:nil];
     
}

-(void)buttonViewClicked:(UIButton *)button{
    NSLog(@"%s [LINE:%d] button.tag =%ld", __func__, __LINE__,button.tag);
}

@end
