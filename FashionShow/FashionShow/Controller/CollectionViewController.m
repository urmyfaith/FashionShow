//
//  CollectionViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "CollectionViewController.h"
#import "ZXDataCenter.h"

/*==========页面View生成===========*/
#import "ZXArticleView.h"
#import "ZXFashionView.h"
#import "ZXVersionView.h"

/*==========页面跳转===========*/
#import "ZXRecordModel.h"
#import "WebViewController.h"
#import "PhotosViewController.h"

#define switchBarHEIGHT 40.0f
#define swithBarBaseTag 1000

typedef enum {
    SwithBarTagWithArticle = swithBarBaseTag,
    SwithBarTagWithFashion,
    SwithBarTagWithVersion
}SwithBarTag;

@interface CollectionViewController ()
@property (nonatomic,strong) NSArray    *selectedImage_array;
@property (nonatomic,strong) NSArray    *unSelectedImage_array;
@end

@implementation CollectionViewController
{
    ZXDataCenter *_dataCenter;
    UIView *_swithBarView;
    
    ZXArticleView *_articleView;
    ZXFashionView *_fashionView;
    ZXVersionView *_versionView;

    CGRect _subViewFrame;
}
#pragma mark  lazy_load
-(NSArray *)selectedImage_array{
    if (_selectedImage_array == nil) {
        _selectedImage_array = [[NSArray alloc]initWithObjects:@"文章_2",@"设置时装_2",@"设置视觉_2",nil];
    }
    return _selectedImage_array;
}

-(NSArray *)unSelectedImage_array{
    if (_unSelectedImage_array == nil) {
        _unSelectedImage_array = [[NSArray alloc]initWithObjects:@"文章_1",@"设置时装_1",@"设置视觉_1",nil];
    }
    return _unSelectedImage_array;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataCenter = [ZXDataCenter sharedDB];

    
    [self createNavitaionbar];
    self.view.backgroundColor = [UIColor blackColor];
    [self createSwithBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //注意先后顺序,先有createSwithBar,后有subView;
    _subViewFrame = CGRectMake(0,
                               CGRectGetMaxY(_swithBarView.frame),
                               zxSCRREN_WIDTH,
                               zxSCRREN_HEIGHT -CGRectGetMaxY(_swithBarView.frame));
    _articleView = [[ZXArticleView alloc]initWithFrame:_subViewFrame];
    _fashionView = [[ZXFashionView alloc]initWithFrame:_subViewFrame];
    _versionView = [[ZXVersionView alloc]initWithFrame:_subViewFrame];
    
    _articleView.delegate = self;
    _fashionView.delegate = self;
    _versionView.delegate = self;
    
    //默认页面
    [self refreshArticleView];
}


-(void)pushToViewControllerWithRecoredModel:(ZXRecordModel *)model{
    
    //1.webVeiw,2,相册
    if (model.recordType == zxDBRecordTypeWithWebView) {
        
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.article_id =  model.article_id;  //用于webView地址的拼接
        webVC.modelType = zxJSON_DATATYPE_GENERIC; //标记数据模型的类型
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else{
        PhotosViewController *photoVC = [[PhotosViewController alloc]init];
        photoVC.gid =  model.article_id;
        if (model.recordType == zxDBRecordTypeWithPhotoViewSJ) {
            photoVC.type = zxDBRecordTypeWithPhotoViewSJ;
        }else{
            photoVC.type = zxDBRecordTypeWithPhotoViewSZ;
        }
        photoVC.favouriteImageHeight = model.favouriteImageHeight;
        photoVC.favouriteImageURL = model.article_image_link;
        [self.navigationController pushViewController:photoVC animated:YES];
    }
}

#pragma mark  创建切换栏

-(void)createSwithBar{
    
     _swithBarView= [[UIView alloc]initWithFrame:CGRectMake(0, zxStatusBar_NavigatinBar_HEIGHT, zxSCRREN_WIDTH, switchBarHEIGHT)];
    _swithBarView.backgroundColor = [UIColor clearColor];
    
    NSUInteger swithBarItemsCount = self.selectedImage_array.count;
    CGFloat switchBarItemWidth = [UIImage imageNamed:@"文章_1"].size.width;
    CGFloat switchBarItemGap = 20.0f;
    CGFloat switchBarLeftGap =(_swithBarView.frame.size.width - swithBarItemsCount*switchBarItemWidth-(swithBarItemsCount-1)*switchBarItemGap )/2;
    
    for (int  index = 0; index < self.selectedImage_array.count; index++) {
        
        CGFloat xPos = switchBarLeftGap + index*(switchBarItemWidth + switchBarItemGap);
        CGFloat yPos = 0.0f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xPos, yPos, switchBarItemWidth, switchBarHEIGHT);
        button.tag = swithBarBaseTag + index;
        [button setImage:[UIImage imageNamed:self.selectedImage_array[index]]
                forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:self.unSelectedImage_array[index]]
                forState:UIControlStateNormal];
        [button  addTarget:self
                    action:@selector(buttonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        [_swithBarView addSubview:button];
        
        //设置默认选中的按钮
        if (index == 0 ) {
            button.selected = YES;
        }
    }
    [self.view addSubview:_swithBarView];
}

#pragma mark 点击按钮-移除视图-重新绘制
/**
 *  切换按钮的点击事件
 *
 *  @param button 点击的方法
 */
-(void)buttonClicked:(UIButton *)button{
    for (int index = 0 ; index < self.selectedImage_array.count; index++) {
        UIButton *swithBarButton = (UIButton *)[self.view viewWithTag:(swithBarBaseTag + index)];
        if ( swithBarButton.tag == button.tag) {
            swithBarButton.selected = YES;
        }
        else{
            swithBarButton.selected = NO;
        }
    }
    
    //移除子视图
    [self removeAllSubViewInView:self.view];
    
    //重新绘制视图
    switch (button.tag) {
        case SwithBarTagWithArticle:
        {
            [self refreshArticleView];
        }
            break;
        case SwithBarTagWithFashion:
        {
            [self refreshFashionView];
        }
            break;
        case SwithBarTagWithVersion:
        {
            [self refreshVersionView];
        }
            break;
    }
}

/**
 *  创建不同的视图:文章视图,时尚视图,视觉视图
 */
-(void)refreshArticleView{
    _articleView.modelsArray = [_dataCenter getAllRecordsWithRecordType:zxDBRecordTypeWithWebView];
    [_articleView drawView];
    [self.view addSubview:_articleView];
}

-(void)refreshFashionView{
    _fashionView.modelsArray = [_dataCenter getAllRecordsWithRecordType:zxDBRecordTypeWithPhotoViewSZ];
    [_fashionView drawView];
    [self.view addSubview:_fashionView];
}

-(void)refreshVersionView{
    _versionView.modelsArray =  [_dataCenter getAllRecordsWithRecordType:zxDBRecordTypeWithPhotoViewSJ];
    [_versionView drawView];
    [self.view addSubview:_versionView];
}

/**
 *  将三种类型的view从视图上移除
 *
 *  @param view 父视图
 */
-(void)removeAllSubViewInView:(UIView *)view{
    for (id subView in view.subviews) {
        if ([subView isKindOfClass:[ZXArticleView class]] ||
            [subView isKindOfClass:[ZXFashionView class]] ||
            [subView isKindOfClass:[ZXVersionView class]]) {
            [((UIView *)subView) removeFromSuperview];
        }
    }
}


#pragma mark 绘制顶部导航栏
//重写root的创建导航栏的方法
-(void)createNavitaionbar{
    
    [self createRootNavigaitonBarWithTitleImag:nil
                                      andIsTop:NO
                                  andTitleName:@"我的收藏"
                            andBackgroundImage:nil
                          andLeftBtnImagesName:@"内文返回_1"
                         andRightBtnImagesName:nil
                                      andClass:self
                                        andSEL:@selector(navigationBarClicked:)];
}

-(void)navigationBarClicked:(UIButton *)button{
    if (button.tag == zxNavigaionBarButtonLeftTag) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
