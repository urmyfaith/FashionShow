//
//  LifeViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "LifeViewController.h"

#import "BeautyModel.h"


@interface LifeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation LifeViewController
{
    NSString *_urlIdentifier;
    UICollectionView *_collectionView;
    NSMutableArray *_collectionViewDateSource_array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.postURL_action = @"list";
    self.postURL_sa = @"SH";
    self.postURL_count = @"18";
    self.postURL_offset = @"0";
    _collectionViewDateSource_array = [[NSMutableArray alloc]init];
    
    [self loadCollectionView];
    [self downloadData];
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
                                            selector:@selector(starPage_downloadFinish)
                                                name:_urlIdentifier
                                              object:nil];
    [[DownloadManager sharedDownloadManager] addDownloadWithDownloadURL:zxAPI_FULLPATH
                                               andDownloadResqustMethod:@"POST"
                                                      andPostDataString:postData_string];
}

-(void)starPage_downloadFinish{
    
    if ([self.postURL_offset isEqualToString:@"0"]) {
        [_collectionViewDateSource_array removeAllObjects];
    }
    [_collectionViewDateSource_array addObjectsFromArray:[JSON2Model JSONData2ModelWithURLIdentifier:_urlIdentifier
                                                                                         andDataType:zxJSON_DATATYPE_BEAUTYPAGE]];
    [_collectionView reloadData];
    [_collectionView headerEndRefreshing];
    [_collectionView footerEndRefreshing];
    
}




#pragma mark 绘制九宫格视图

-(void)loadCollectionView{
    ZXCustomCVFL *flowLayout = [[ZXCustomCVFL alloc]init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,
                                                                        zxStatusBar_NavigatinBar_HEIGHT,
                                                                        self.view.frame.size.width,
                                                                        self.view.frame.size.height - zxStatusBar_NavigatinBar_HEIGHT)
                                        collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[StarCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_collectionView addHeaderWithTarget:self action:@selector(loadNewItem)];
    [_collectionView addFooterWithTarget:self action:@selector(loadMoreItem)];
}


-(void)loadNewItem{
    self.postURL_offset = @"0";
    [self downloadData];
}

-(void)loadMoreItem{
    static int page = 1;
    self.postURL_offset = [NSString stringWithFormat:@"%d",self.postURL_count.intValue * page];
    page++;
    [self downloadData];
}


#pragma mark delegateMethod

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_collectionViewDateSource_array count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    StarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    BeautyModel *bm = (BeautyModel *)[_collectionViewDateSource_array objectAtIndex:indexPath.row];
    
    [cell.imageView  setImageWithURL:[NSURL URLWithString:bm.icon] placeholderImage:[UIImage imageNamed:@"明星缺省图"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s [LINE:%d] indexPatsh=%d", __func__, __LINE__,indexPath.row);
    WebViewController *webVC = [[WebViewController alloc]init];
    GenericModel *model = (GenericModel *)[_collectionViewDateSource_array objectAtIndex:indexPath.row];
    
    webVC.article_id =  model.id;  //用于webView地址的拼接
    webVC.model = model; //用于收藏webView的时候,展示收藏页面的标题.
    webVC.modelType = zxJSON_DATATYPE_GENERIC; //标记数据模型的类型
    
    ZXTabBarVC *tvc = [ZXTabBarVC sharedZXTabBarViewController];
    tvc.customTabBar.hidden = YES;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

//设置每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(104, 140);
}

//设置cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

//设置cell之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}



@end
