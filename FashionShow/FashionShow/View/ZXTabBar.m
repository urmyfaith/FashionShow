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

/*==========导入友盟库===========*/
#import "UMSocial.h"

/**
 *  详细页面的ToolBar:返回前一页,分享,收藏,评论
 */

/**
 *  导入数据库,数据库记录模型
 *
 */
#import "ZXDataCenter.h"
#import "ZXRecordModel.h"


@interface ZXTabBar ()<UIActionSheetDelegate>

@end

@implementation ZXTabBar
{
    id _currentClassObject;
    NSString *_downlaod_url;
    NSString *_article_id;
    NSString *_article_title;
    NSString *_image_url;
    CGFloat _favouriteImageHeight;
    zxDBRecordType _recoredType;
    ZXRecordModel *_recoredModel;
    
   __block UIImage *_shareImage;
    
    BOOL _operateDateBaseStatus;
    BOOL _isModelInDataBase;
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

    /*
     1.返回，无需特殊数据
     2.下载，下载需要当前页面的［图片地址］ ---完成
     3.分享，需要当前页面的［数据模型］／［链接］－－－－》 一张图片 ｜ 链接＝＝》短链接 ---完成
     4.收藏，收藏需要当前的［数据模型］／［链接］－－－－》图片／数据模型  ｜ 链接 #todo
     5.评论，需要［数据模型］／［链接］         －－－－－》得到文章id --完成
     */
    
    if([curren_vc isKindOfClass:[PhotosViewController class]])
    {
        GenericModel *gm  = (GenericModel *) [ ((PhotosViewController* )curren_vc).dataSource_mArray
                                                objectAtIndex:( (PhotosViewController* )curren_vc).currentPage ];
        
        //修改存储图片的地址
        _image_url = ((PhotosViewController* )curren_vc).favouriteImageURL;
        //_image_url = gm.icon;
        
        
        _article_id = gm.id;
        _downlaod_url = ((PhotosViewController* )curren_vc).urlIdentifier;
        _recoredType = ((PhotosViewController*)curren_vc).type;
        _favouriteImageHeight = ((PhotosViewController *)curren_vc).favouriteImageHeight;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadWithURL:[NSURL URLWithString:_image_url]
                         options:0
                        progress:nil
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
         {
             if (image)
             {
                 _shareImage = image;
             }
         }];
    }
    if([curren_vc isKindOfClass:[WebViewController class]]){
        _article_id = ((WebViewController*)curren_vc).article_id;
        _downlaod_url = ((WebViewController*)curren_vc).urlIdentifier;
        _recoredType = zxDBRecordTypeWithWebView;
        _article_title =((WebViewController*)curren_vc).article_title;
    }
    
    _recoredModel = [[ZXRecordModel alloc]init];
    _recoredModel.recordType = _recoredType;
    _recoredModel.article_title = _article_title;
    _recoredModel.article_link = _downlaod_url;
    _recoredModel.article_id = _article_id;
    _recoredModel.article_image_link = _image_url;
    _recoredModel.favouriteImageHeight = _favouriteImageHeight;
    
    NSLog(@"%s %d -- image_url=%@, article_id=%@ downlaod_url=%@",__func__,__LINE__,_image_url,_article_id,_downlaod_url);
    
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
            NSLog(@"%s [LINE:%d] image_url=%@", __func__, __LINE__,_image_url);
            [self saveImageToPhotos:_shareImage];
        }
            break;
            
#pragma mark  分享按钮事件处理 --友盟分享
        case zxTabBarButtonBaseTag+2:
        {
           NSLog(@"%s [LINE:%d] image_url=%@ or downlaod_url=%@", __func__, __LINE__,_image_url,_downlaod_url);

            [UMSocialSnsService presentSnsIconSheetView:curren_vc
                                                 appKey:zxYOUMENG_APPKEY
                                              shareText:[NSString stringWithFormat:@"我在看%@ ,",_downlaod_url]
                                             shareImage:_shareImage
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,
                                                         UMShareToTencent,
                                                         UMShareToRenren,
                                                         UMShareToQzone,
                                                         nil]
                                               delegate:nil];
            
        }
            break;
            
#pragma mark  收藏按钮事件处理
        case zxTabBarButtonBaseTag+3:
        {
            //收藏事件
            //显示收藏的的模型是传递过来模型,===>数据库===>用于显示收藏
            //收藏实际跳转的时候,需要webview,这个数据也需要缓存==>用于从收藏页面跳转到实际的webView页面.
            
            //在按钮点击的时候,得到的是收藏页面的VC,包含了收藏的webView页面.
            /**
             分析:
            - 对于普通的网页,只需要收藏链接地址和和title ==>WebView传过来的.
            - 对于时装和视觉页面,需要收藏 第一张图片, 和页面的id.
        
             设计数据库:
             1.插入,查询,删除.
             2.字段设计  index(自动增长),类型(WebView/PhotoView),title,link,article_id,image
             3.需要有的方法:
              收藏-->根据类型--->数据查询(是否存在)/插入数据
              显示收藏--->根据类型--->查询数据
              取消收藏--->根据类型和id--->删除数据
             */
            if (_recoredModel.recordType == zxDBRecordTypeWithWebView &&
                _recoredModel.article_title == nil) {
                NSString *errMsg = @"请等待网页加载完成";
                [[[iToast makeText:errMsg ]setDuration:iToastDurationNormal] show];
            }
            else{
                ZXDataCenter *dc = [ZXDataCenter sharedDB];
                _isModelInDataBase = [dc isInDataBaseWithModel:_recoredModel];
                NSLog(@"%s [LINE:%d]isInDB=%@", __func__, __LINE__,_operateDateBaseStatus==YES?@"YES":@"NO");
                
                UIButton *collectionButton = (UIButton *)[self viewWithTag:button.tag];
                
                if (_isModelInDataBase) {
                    _operateDateBaseStatus =  [dc deleteRecordWithModel:_recoredModel];
                    NSLog(@"%s [LINE:%d]delete data=%@", __func__, __LINE__,_operateDateBaseStatus==YES?@"YES":@"NO");
                    [[[iToast makeText:@"已移除收藏!" ]setDuration:iToastDurationNormal] show];
                    [collectionButton setImage:[UIImage imageNamed:@"收藏_1"]
                                      forState:UIControlStateNormal];
                }
                else{
                    _operateDateBaseStatus =   [dc addRecordWithModel:_recoredModel];
                    NSLog(@"%s [LINE:%d]add data=%@", __func__, __LINE__,_operateDateBaseStatus==YES?@"YES":@"NO");
                    [[[iToast makeText:@"已收藏!" ]setDuration:iToastDurationNormal] show];
                    [collectionButton setImage:[UIImage imageNamed:@"已收藏_1"]
                                      forState:UIControlStateNormal];
                }
            }
        }
            break;
#pragma mark  评论按钮事件处理
        case zxTabBarButtonBaseTag+4:
        {
            NSLog(@"%s [LINE:%d] 点击了评论", __func__, __LINE__);

            ShowCommentsViewController *svc = [[ShowCommentsViewController alloc]init];
            svc.comment_article_id = _article_id;
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

#pragma mark 保存图片到相册的回调方法

/*
 判断是否保存成功,然后弹出消息
 */
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
