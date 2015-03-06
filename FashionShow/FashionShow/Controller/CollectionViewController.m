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
@property (nonatomic,strong) NSArray    *records_array;
@end

@implementation CollectionViewController
{
    ZXDataCenter *_dataCenter;
    UIView *_swithBarView;
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

-(NSArray *)records_array{
    if (_records_array == nil) {
        _records_array = [[NSArray alloc]init];
    }
    return _records_array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataCenter = [ZXDataCenter sharedDB];
    
    [self createNavitaionbar];
    self.view.backgroundColor = [UIColor blackColor];
    [self createSwithBar];
    
    //默认页面
    [self createArticleView];
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
        
        if (index == 0 ) {
            button.selected = YES;
        }
    }
    [self.view addSubview:_swithBarView];
}

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
            [self createArticleView];
        }
            break;
        case SwithBarTagWithFashion:
        {
            [self createFashionView];
        }
            break;
        case SwithBarTagWithVersion:
        {
            [self createVersionView];
        }
            break;
    }
}

/**
 *  创建不同的视图:文章视图,时尚视图,视觉视图
 */
-(void)createArticleView{
    self.records_array =   [_dataCenter getAllRecordsWithRecordType:zxDBRecordTypeWithWebView];
    ZXArticleView *av = [[ZXArticleView alloc]init];
    av.frame = CGRectMake(0,
                          CGRectGetMaxY(_swithBarView.frame),
                          zxSCRREN_WIDTH,
                          zxSCRREN_HEIGHT -CGRectGetMaxY(_swithBarView.frame));
    [self.view addSubview:av];
    NSLog(@"%s [LINE:%d] #todo ", __func__, __LINE__);
}

-(void)createFashionView{
    self.records_array =   [_dataCenter getAllRecordsWithRecordType:zxDBRecordTypeWithPhotoViewSZ];
    NSLog(@"%s [LINE:%d] #todo ", __func__, __LINE__);
}

-(void)createVersionView{
    self.records_array =   [_dataCenter getAllRecordsWithRecordType:zxDBRecordTypeWithPhotoViewSJ];
    NSLog(@"%s [LINE:%d] #todo ", __func__, __LINE__);
}

-(void)removeAllSubViewInView:(UIView *)view{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
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
