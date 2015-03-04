//
//  ZXTabBar.m
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXTabBar.h"
#import "ShowCommentsViewController.h"
#import "GenericModel.h"

//引入webView
#import "WebViewController.h"
/*

 */


#import "PhotosViewController.h"

/*
 //json转数据模型
 #import "JSON2Model.h"
 #import "GenericModel.h"
 */


#import "ZXTabBarVC.h"


/**
 *  引入弹出消息提示框
 */
#import "iToast.h"

/**
 *  详细页面的ToolBar:返回前一页,分享,收藏,评论
 */

@implementation ZXTabBar
{
    id _currentClassObject;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(ZXTabBar *)tabBarWithImagesArray:(NSArray *)imagesArray
                          andClass:(id)classObject
                            andSEL:(SEL)sel{
    
    _currentClassObject = classObject;
    
    //背景图片---写在最前面.
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"一级栏目底"];
    [self addSubview:backgroundImageView];
    
    //64*49每张图片大小
    //(320 - 64*5)*6 = gap
    
    CGFloat singlePhotoWidth = 64.0f;
    CGFloat gap = (self.frame.size.width- singlePhotoWidth*imagesArray.count)/(imagesArray.count + 1);
    
    if (imagesArray.count > 0 ) {
        for (int index = 0 ; index < imagesArray.count; index++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = zxTabBarButtonBaseTag+ index;
            
            UIImage *buttonImage = [UIImage imageNamed:imagesArray[index]];
            button.frame = CGRectMake(gap + buttonImage.size.width*index,
                                      (self.frame.size.height - buttonImage.size.height)/2,
                                      buttonImage.size.width,
                                      buttonImage.size.height);
            [button setImage:buttonImage forState:UIControlStateNormal];
            
            //如果子类需要修改的时候,sel不为空,子类自己实现点击方法
            //target为子类自己
            if (sel != nil) {
                [button addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
            }else{
                //如果sel == nil,由父类来完成默认的点击事件的处理
                //target为当前的类
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self addSubview:button];
        }
    }
    return self;
}

-(void)buttonClick:(UIButton *)button{

    UIViewController *curren_vc = (UIViewController *)_currentClassObject;


    NSString *downlaod_url = nil;
    NSString *article_id = nil;
    NSString *image_url = nil;
    
    
    /*
     1.返回，无需特殊数据
     2.下载，下载需要当前页面的［图片地址］
     3.分享，需要当前页面的［数据模型］／［链接］－－－－》 一张图片 ｜ 链接＝＝》短链接
     4.收藏，收藏需要当前的［数据模型］／［链接］－－－－》图片／数据模型  ｜ 链接
     5.评论，需要［数据模型］／［链接］         －－－－－》得到文章id
     */
    
    if([curren_vc isKindOfClass:[PhotosViewController class]])
    {
        GenericModel *gm  = (GenericModel *) [ ((PhotosViewController* )curren_vc).dataSource_mArray
                                                objectAtIndex:( (PhotosViewController* )curren_vc).currentPage ];
        image_url = gm.icon;
        article_id = gm.id;
        downlaod_url = ((PhotosViewController* )curren_vc).urlIdentifier;
    }
    if([curren_vc isKindOfClass:[WebViewController class]]){
        article_id = ((WebViewController*)curren_vc).article_id;
        downlaod_url = ((WebViewController*)curren_vc).urlIdentifier;
    }
    NSLog(@"%s %d -- image_url=%@, article_id=%@ downlaod_url=%@",__func__,__LINE__,image_url,article_id,downlaod_url);
    
    switch (button.tag) {
            
#pragma mark  返回按钮事件处理
        case zxTabBarButtonBaseTag:
        {
            ZXTabBarVC *tvc = [ZXTabBarVC sharedZXTabBarViewController];
            tvc.customTabBar.hidden = NO;
            [curren_vc.navigationController popViewControllerAnimated:YES];
        }
            break;
#pragma mark  下载按钮事件处理
        case zxTabBarButtonBaseTag+1:
        {
            
           NSLog(@"%s [LINE:%d] image_url=%@", __func__, __LINE__,image_url);
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadWithURL:image_url
                             options:0
                            progress:nil
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
             {
                 if (image)
                 {
                     [self saveImageToPhotos:image];
                 }
             }];
        }
            break;
            
#pragma mark  分享按钮事件处理
        case zxTabBarButtonBaseTag+2:
        {
           NSLog(@"%s [LINE:%d] image_url=%@ or downlaod_url=%@", __func__, __LINE__,image_url,downlaod_url);
        }
            break;
#pragma mark  收藏按钮事件处理
        case zxTabBarButtonBaseTag+3:
        {
            //收藏事件
            //显示收藏的的模型是传递过来模型,===>数据库===>用于显示收藏
            //收藏实际跳转的时候,需要webview,这个数据也需要缓存==>用于从收藏页面跳转到实际的webView页面.
            
            //在按钮点击的时候,得到的是收藏页面的VC,包含了收藏的webView页面.

        }
            break;
#pragma mark  评论按钮事件处理
        case zxTabBarButtonBaseTag+4:
        {
            NSLog(@"%s [LINE:%d] 点击了评论", __func__, __LINE__);

            ShowCommentsViewController *svc = [[ShowCommentsViewController alloc]init];
            //[ curren_vcisKindOfClass:[WebViewController class]]
            if ([curren_vc isKindOfClass:NSClassFromString(@"WebViewController")]) {
                svc.comment_article_id = ((WebViewController *)curren_vc).article_id;
            }
            [curren_vc.navigationController pushViewController:svc animated:YES];
        }
            break;
    }
}

#pragma mark 保存图片
/**
 *  保存图片
 *  操作就一个C函数,可以仅使用一个参数,当然也可以使用回调方法.
 *
 *  @param savedImage 待保存的图片
 */
- (void)saveImageToPhotos:(UIImage*)savedImage
{

#if 1
    UIImageWriteToSavedPhotosAlbum(savedImage,
                                   self,
                                   @selector(image:didFinishSavingWithError:contextInfo:),
                                   nil);
#else
    UIImageWriteToSavedPhotosAlbum(savedImage,
                                   nil,
                                   nil,
                                   nil);
#endif
    
#if 0
    
    //调试的时候,使用quickLook来查看imageView,可以看到图片是存在的,全部使用nil也解决不了问题.
    //最后发现使用高版本可以解决此问题:Xcode6+,iOS7+
    UIImageView *imageView = [[UIImageView alloc]initWithImage:savedImage];
    imageView.frame =CGRectMake(100, 100, 100, 100);
#endif
}

- (void)image:(UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    NSString *msg = nil ;
    if(error != nil){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    NSLog(@"%s [LINE:%d] msg=%@", __func__, __LINE__,msg);
    [[[iToast makeText:msg ]setDuration:iToastDurationNormal] show];
}








@end
