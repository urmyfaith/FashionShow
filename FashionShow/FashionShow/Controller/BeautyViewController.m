//
//  BeautyViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "BeautyViewController.h"

/*==========滚动视图(添加子控件)===========*/
#import "BeautyView.h"
#import "BeautyModel.h"



@interface BeautyViewController ()
@property (nonatomic,strong) NSMutableArray    *beautyModels_mArray;
@property (nonatomic,strong)  BeautyView    *beautyView;
@end

@implementation BeautyViewController
{
    NSString *_urlIdentifier;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    
    [self dataInitilnize];
    [self downloadData];
}

#pragma mark ---lazy_load_array
-(NSMutableArray *)beautyModels_mArray{
    if (nil == _beautyModels_mArray) {
        _beautyModels_mArray   = [[NSMutableArray alloc]init];
    }
    return _beautyModels_mArray;
}

/**
 *  数据初始化工作
 *  URL数据初始化.
 */
-(void)dataInitilnize{
    
    self.postURL_action = @"list";
    self.postURL_sa = @"MR";
    self.postURL_count = @"18";
    self.postURL_offset = @"0";
}


#pragma mark 下载数据
-(void)downloadData{
    NSString *postData_string = [NSString stringWithFormat:zxpostData_string,
                                 self.postURL_action,
                                 self.postURL_sa,
                                 self.postURL_offset,
                                 self.postURL_count];
    
    _urlIdentifier= [NSString stringWithFormat:@"%@%@",zxAPI_FULLPATH,postData_string];
    
    NSLog(@"_urlIdentifier=%@",_urlIdentifier);
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(fashionPage_downloadFinish)
                                                name:_urlIdentifier
                                              object:nil];
    [[DownloadManager sharedDownloadManager] addDownloadWithDownloadURL:zxAPI_FULLPATH
                                               andDownloadResqustMethod:@"POST"
                                                      andPostDataString:postData_string];
    
}

-(void)fashionPage_downloadFinish{
    
    if ([self.postURL_offset isEqualToString:@"0"]) {
        [self.beautyModels_mArray removeAllObjects];
    }
    NSArray *json2Moodel_array = [JSON2Model JSONData2ModelWithURLIdentifier:_urlIdentifier
                                                                 andDataType:zxJSON_DATATYPE_BEAUTYPAGE];
    
    //数据下载完成后,创建View
    
    if (json2Moodel_array.count > 0 ) {
        NSLog(@"%s [LINE:%d]", __func__, __LINE__);
        [self.beautyModels_mArray addObjectsFromArray:json2Moodel_array];
    }
    else{
        [[[iToast makeText:@"亲,没数据啦!"] setDuration:iToastDurationNormal] show:iToastTypeNotice];
    }
    if (self.beautyView == nil) {
        [self createBeautyView];
    }
    else{
        [self refreshBeautyView];
    }
    [self.beautyView headerEndRefreshing];
    [self.beautyView footerEndRefreshing];
}


/**
 *  1.创建View
 *  2.准备数据
 *  3.绘制控件
 *  4.调整frame
 */
-(void)createBeautyView{

//    self.beautyView = [[BeautyView alloc]init];
    self.beautyView = [[BeautyView alloc]initWithViewController:self];
    [self refreshBeautyView];
    [self.view addSubview:self.beautyView];
    
    //添加数据刷新
    [self.beautyView addHeaderWithTarget:self action:@selector(loadNewItems)];
    [self.beautyView addFooterWithTarget:self action:@selector(loadMoreItems)];
}


#pragma mark 刷新数据的方法
-(void)loadNewItems{
    self.postURL_offset = @"0";
    [self downloadData];
}
-(void)loadMoreItems{
    static int page = 1;
    self.postURL_offset = [NSString stringWithFormat:@"%d",self.postURL_count.intValue * page];
    page++;
    [self downloadData];
}

/**
 *  更新数据,重新绘制,调整frame
 */
-(void)refreshBeautyView{
    self.beautyView.models_array = self.beautyModels_mArray;
    self.beautyView.frame = CGRectMake(0,
                                       zxStatusBar_NavigatinBar_HEIGHT,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height-zxStatusBar_NavigatinBar_HEIGHT);
    [self.beautyView drawBeautyView];
    self.beautyView.contentSize = CGSizeMake(self.view.frame.size.width, self.beautyView.currentHeight);
}

-(void)clickedOneRowViewAtIndex:(NSNumber *)index{
    NSLog(@"%s %d %@",__func__,__LINE__,index);
    
    WebViewController *webVC = [[WebViewController alloc]init];
    GenericModel *model = (GenericModel *)[self.beautyModels_mArray objectAtIndex:index.intValue];
    
    webVC.article_id =  model.id;  //用于webView地址的拼接
    webVC.model = model; //用于收藏webView的时候,展示收藏页面的标题.
    webVC.modelType = zxJSON_DATATYPE_GENERIC; //标记数据模型的类型
    
    ZXTabBarVC *tvc = [ZXTabBarVC sharedZXTabBarViewController];
    tvc.customTabBar.hidden = YES;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}


@end
