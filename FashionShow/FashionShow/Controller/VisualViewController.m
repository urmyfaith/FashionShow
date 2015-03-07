//
//  VisualViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "VisualViewController.h"
#import "BeautyModel.h"
#import "ZKDataCache.h"
#import "ODRefreshControl.h"

@interface VisualViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation VisualViewController
{
    NSString *_urlIdentifier;
    UICollectionView *_collectionView;
    NSMutableArray *_collectionViewDateSource_array;
    
    ODRefreshControl *_refreshControl;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.postURL_action = @"list";
    self.postURL_sa = @"SJ";
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
    //[_collectionView headerEndRefreshing];
    [_refreshControl endRefreshing];
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
    
     _refreshControl = [[ODRefreshControl alloc] initInScrollView:_collectionView];
    [_refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    //[_collectionView addHeaderWithTarget:self action:@selector(loadNewItem)];
    
    [_collectionView addFooterWithTarget:self action:@selector(loadMoreItem)];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
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

    //自己混存图片代理SDWebImage混存图片,这样得到key就比较简单-->key(url)
#if 0
    [cell.imageView  setImageWithURL:[NSURL URLWithString:bm.icon] placeholderImage:[UIImage imageNamed:@"明星缺省图"]];
#else
    ZKDataCache *dataCache = [ZKDataCache sharedInstance];
    [dataCache setImageOfImageView:cell.imageView
   withImageCacheOrDownloadFromURL:bm.icon];
#endif
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s [LINE:%d] indexPatsh=%ld", __func__, __LINE__,indexPath.row);
    PhotosViewController *photoVC = [[PhotosViewController alloc]init];
    BeautyModel *model = (BeautyModel *)[_collectionViewDateSource_array objectAtIndex:indexPath.row];
    
    photoVC.favouriteImageHeight = 140.0f;//用于记录收藏图片-->高度
    photoVC.favouriteImageURL = model.icon;
    
    photoVC.gid =  model.id;  //用于webView地址的拼接
    photoVC.type = zxDBRecordTypeWithPhotoViewSJ;//标记来自视觉页面;
    ZXTabBarVC *tvc = [ZXTabBarVC sharedZXTabBarViewController];
    tvc.customTabBar.hidden = YES;
    
    [self.navigationController pushViewController:photoVC animated:YES];
}

//设置每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(159, 140);
}

//设置cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

//设置cell之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}





@end
